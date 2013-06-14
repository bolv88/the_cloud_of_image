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

      "-101" => "machine id 错误",
      "-102" => "邮箱已被注册",
      "-103" => "注册失败",

      "-201" => "圈子创建失败",

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
        return self.raise_exception -9002
    end

    #根据token获取user_id
    new_name = "_"+name.to_s
    token = args.shift
    request_time = args.shift
    sign = args.shift

    self.api_user_id = self.getUserIdByToken token

    if (not self.api_user_id) and (not self.not_authed_methods.include? new_name)
        self.raise_exception -1
    end

    #调用实际函数
    if self.respond_to? new_name
        return self.send(new_name, *args, &block)
    else
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

end
