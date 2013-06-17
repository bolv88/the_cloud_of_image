#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'user_api_types'

    module Blublu
      module User_api
        class Client
          include ::Thrift::Client

          def login(token, request_datetime, sign, email, password)
            send_login(token, request_datetime, sign, email, password)
            return recv_login()
          end

          def send_login(token, request_datetime, sign, email, password)
            send_message('login', Login_args, :token => token, :request_datetime => request_datetime, :sign => sign, :email => email, :password => password)
          end

          def recv_login()
            result = receive_message(Login_result)
            return result.success unless result.success.nil?
            raise result.ouch unless result.ouch.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'login failed: unknown result')
          end

          def regist(token, request_datetime, sign, email, password)
            send_regist(token, request_datetime, sign, email, password)
            return recv_regist()
          end

          def send_regist(token, request_datetime, sign, email, password)
            send_message('regist', Regist_args, :token => token, :request_datetime => request_datetime, :sign => sign, :email => email, :password => password)
          end

          def recv_regist()
            result = receive_message(Regist_result)
            return result.success unless result.success.nil?
            raise result.ouch unless result.ouch.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'regist failed: unknown result')
          end

        end

        class Processor
          include ::Thrift::Processor

          def process_login(seqid, iprot, oprot)
            args = read_args(iprot, Login_args)
            result = Login_result.new()
            begin
              result.success = @handler.login(args.token, args.request_datetime, args.sign, args.email, args.password)
            rescue Blublu::InvalidOperation => ouch
              result.ouch = ouch
            end
            write_result(result, oprot, 'login', seqid)
          end

          def process_regist(seqid, iprot, oprot)
            args = read_args(iprot, Regist_args)
            result = Regist_result.new()
            begin
              result.success = @handler.regist(args.token, args.request_datetime, args.sign, args.email, args.password)
            rescue Blublu::InvalidOperation => ouch
              result.ouch = ouch
            end
            write_result(result, oprot, 'regist', seqid)
          end

        end

        # HELPER FUNCTIONS AND STRUCTURES

        class Login_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          TOKEN = 1
          REQUEST_DATETIME = 2
          SIGN = 3
          EMAIL = 4
          PASSWORD = 5

          FIELDS = {
            TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'},
            REQUEST_DATETIME => {:type => ::Thrift::Types::I64, :name => 'request_datetime'},
            SIGN => {:type => ::Thrift::Types::STRING, :name => 'sign'},
            EMAIL => {:type => ::Thrift::Types::STRING, :name => 'email'},
            PASSWORD => {:type => ::Thrift::Types::STRING, :name => 'password'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Login_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          OUCH = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
            OUCH => {:type => ::Thrift::Types::STRUCT, :name => 'ouch', :class => Blublu::InvalidOperation}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Regist_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          TOKEN = 1
          REQUEST_DATETIME = 2
          SIGN = 3
          EMAIL = 4
          PASSWORD = 5

          FIELDS = {
            TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'},
            REQUEST_DATETIME => {:type => ::Thrift::Types::I64, :name => 'request_datetime'},
            SIGN => {:type => ::Thrift::Types::STRING, :name => 'sign'},
            EMAIL => {:type => ::Thrift::Types::STRING, :name => 'email'},
            PASSWORD => {:type => ::Thrift::Types::STRING, :name => 'password'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Regist_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          OUCH = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
            OUCH => {:type => ::Thrift::Types::STRUCT, :name => 'ouch', :class => Blublu::InvalidOperation}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

      end

    end