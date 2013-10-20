#coding: utf-8
$:.push('./gen-rb')
require 'thrift'
require 'site_shared_types'
class BaseApiController < ApplicationController
  attr_accessor :token, :api_user_id, :not_authed_methods

  def initialize
    super
    self.not_authed_methods = []
  end
  def raise_exception what,why=''
    what = what.to_s
    conf = {
      "-1" => "请先登陆",
      "-2" => "token错误",
      "-6" => "签名错误",


      "-3" => "圈子不存在",
      "-4" => "用户不存在",
      "-5" => "用户不为圈子管理员",

      "-201" => "圈子创建失败",
      "-202" => "资源不存在",
      "-203" => "当前用户不能处理该请求",
      "-204" => "该请求已终结, 不能修改",

      "-6" => "请求失败",

      "-101" => "machine id 错误",
      "-102" => "邮箱已被注册",
      "-103" => "注册失败",


      "-9001" => "方法不存在",
      "-9002" => "参数个数太少",
    }
    rs_why = conf[what]
    if why.respond_to? "each"
        error = ""
        why.each{|a, b|
          error += "#{a} #{b}\n"
        }
        rs_why += "(#{error})"
    else
        if why.length > 0
          rs_why += "(#{why})"
        end
    end
    raise Blublu::InvalidOperation.new(:what=>what.to_i, :why=>rs_why)
  end

  def method_missing(name, *args, &block)
    if args.length < 3
        p "method not found: #{name}"
        return self.raise_exception -9002, name
    end

    p args

    #获取参数
    new_name = "_"+name.to_s
    token = args.shift
    request_time = args.shift
    sign = args.shift
    
    #验证签名
    sec = "fffgggttt076665"
    to_sign_string = "#{token}##{request_time}##{sec}"
    puts to_sign_string
    puts Digest::MD5.hexdigest(to_sign_string)
    if sign != Digest::MD5.hexdigest(to_sign_string)
      raise_exception -6, "#{token} #{request_time} #{sign}"
    end

    #根据token获取user_id
    self.api_user_id = self.getUserIdByToken token

    if (not self.api_user_id) and (not self.not_authed_methods.include? new_name)
        self.raise_exception -1
    end

    #调用实际函数
    if self.respond_to? new_name
        return self.send(new_name, *args, &block)
    else
      p new_name
        return self.raise_exception -9001
    end
  end

  def getUserIdByToken token
    tokens = token.split("#")
    if tokens.length < 2
      return nil
    end

    token = UserToken.where(:machine_id=>tokens[0], :token=>tokens[1]).first

    if not token
        return nil
    end

    return token.user_id.to_i
  end

  def getUserIdByToken! token
    user_id = self.getUserIdByToken token
    if not user_id
        self.raise_exception -1
    end
    return user_id
  end

end
