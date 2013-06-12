$:.push('./gen-rb')
require 'thrift'
require 'photos'
require 'user_api'

class ApiUserController < ApplicationController
  def index
    input_buffer = request.raw_post
    output_buffer = StringIO.new

    handler = self

    processor = Blublu::User_api::Processor.new(handler)

    transport = Thrift::IOStreamTransport.new StringIO.new(input_buffer), output_buffer

    protocol_factory = Thrift::BinaryProtocolFactory.new()
    protocol = protocol_factory.get_protocol transport

    processor.process protocol, protocol

    send_data output_buffer.string
  end

  def login machine_id, request_time, sign, email, password
    if machine_id.length < 10
      return ""
    end
    
    user = User.find_by_email(email)

    if not user
      return ""
    end

    if user.valid_password? password
      existTokens = UserToken.where(:machine_id => machine_id)
      existTokens.each{|one_token| one_token.destroy}

      token = Time.new.to_i.to_s+"."+rand(10000).to_s

      userToken = UserToken.new(:machine_id => machine_id, :token=>token, :user_id => user.id)
      userToken.save!

      return token
    else
      return ""
    end
  end

  def raise_exception what,why=''
    what = what.to_s
    conf = {
      "-101" => "machine id 错误",
      "-102" => "邮箱已被注册",
      "-103" => "注册失败",
    }
    rs_why = conf[what]
    if why.length > 0
      rs_why += "(#{why})"
    end
    raise Blublu::InvalidOperation.new(:what=>what.to_i, :why=>rs_why)
  end

  def regist machine_id, request_time, sign, email, password
    if machine_id.length < 10
      self.raise_exception -101
    end
    
    user = User.find_by_email(email)
    if user
      self.raise_exception -102
    end

    user = User.new(:email => email, :password=>password, :password_confirmation=>password)

    begin
      if not user.save!
        error = ""
        user.errors.each{|e|
          error += "#{e[0]} #{e[1]}\n"
        }
        self.raise_exception -103, error
      end
    rescue
      self.raise_exception -103, $!.to_s
    end

    return self.login machine_id, request_time, sign, email, password
  end
end
