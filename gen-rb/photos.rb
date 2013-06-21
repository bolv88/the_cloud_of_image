#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'photos_types'

    module Blublu
      module Photos
        class Client
          include ::Thrift::Client

          def getUserPhotos(token, request_datetime, sign, search_param)
            send_getUserPhotos(token, request_datetime, sign, search_param)
            return recv_getUserPhotos()
          end

          def send_getUserPhotos(token, request_datetime, sign, search_param)
            send_message('getUserPhotos', GetUserPhotos_args, :token => token, :request_datetime => request_datetime, :sign => sign, :search_param => search_param)
          end

          def recv_getUserPhotos()
            result = receive_message(GetUserPhotos_result)
            return result.success unless result.success.nil?
            raise result.ouch unless result.ouch.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getUserPhotos failed: unknown result')
          end

          def getFeedPhotos(token, request_datetime, sign, search_param)
            send_getFeedPhotos(token, request_datetime, sign, search_param)
            return recv_getFeedPhotos()
          end

          def send_getFeedPhotos(token, request_datetime, sign, search_param)
            send_message('getFeedPhotos', GetFeedPhotos_args, :token => token, :request_datetime => request_datetime, :sign => sign, :search_param => search_param)
          end

          def recv_getFeedPhotos()
            result = receive_message(GetFeedPhotos_result)
            return result.success unless result.success.nil?
            raise result.ouch unless result.ouch.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getFeedPhotos failed: unknown result')
          end

          def test(a)
            send_test(a)
            return recv_test()
          end

          def send_test(a)
            send_message('test', Test_args, :a => a)
          end

          def recv_test()
            result = receive_message(Test_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'test failed: unknown result')
          end

          def addImage(token, request_datetime, sign, imageString, groupId)
            send_addImage(token, request_datetime, sign, imageString, groupId)
            return recv_addImage()
          end

          def send_addImage(token, request_datetime, sign, imageString, groupId)
            send_message('addImage', AddImage_args, :token => token, :request_datetime => request_datetime, :sign => sign, :imageString => imageString, :groupId => groupId)
          end

          def recv_addImage()
            result = receive_message(AddImage_result)
            return result.success unless result.success.nil?
            raise result.ouch unless result.ouch.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'addImage failed: unknown result')
          end

        end

        class Processor
          include ::Thrift::Processor

          def process_getUserPhotos(seqid, iprot, oprot)
            args = read_args(iprot, GetUserPhotos_args)
            result = GetUserPhotos_result.new()
            begin
              result.success = @handler.getUserPhotos(args.token, args.request_datetime, args.sign, args.search_param)
            rescue Blublu::InvalidOperation => ouch
              result.ouch = ouch
            end
            write_result(result, oprot, 'getUserPhotos', seqid)
          end

          def process_getFeedPhotos(seqid, iprot, oprot)
            args = read_args(iprot, GetFeedPhotos_args)
            result = GetFeedPhotos_result.new()
            begin
              result.success = @handler.getFeedPhotos(args.token, args.request_datetime, args.sign, args.search_param)
            rescue Blublu::InvalidOperation => ouch
              result.ouch = ouch
            end
            write_result(result, oprot, 'getFeedPhotos', seqid)
          end

          def process_test(seqid, iprot, oprot)
            args = read_args(iprot, Test_args)
            result = Test_result.new()
            result.success = @handler.test(args.a)
            write_result(result, oprot, 'test', seqid)
          end

          def process_addImage(seqid, iprot, oprot)
            args = read_args(iprot, AddImage_args)
            result = AddImage_result.new()
            begin
              result.success = @handler.addImage(args.token, args.request_datetime, args.sign, args.imageString, args.groupId)
            rescue Blublu::InvalidOperation => ouch
              result.ouch = ouch
            end
            write_result(result, oprot, 'addImage', seqid)
          end

        end

        # HELPER FUNCTIONS AND STRUCTURES

        class GetUserPhotos_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          TOKEN = 1
          REQUEST_DATETIME = 2
          SIGN = 3
          SEARCH_PARAM = 4

          FIELDS = {
            TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'},
            REQUEST_DATETIME => {:type => ::Thrift::Types::I64, :name => 'request_datetime'},
            SIGN => {:type => ::Thrift::Types::STRING, :name => 'sign'},
            SEARCH_PARAM => {:type => ::Thrift::Types::STRUCT, :name => 'search_param', :class => Blublu::SearchParam}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class GetUserPhotos_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          OUCH = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => Blublu::PhotoObject}},
            OUCH => {:type => ::Thrift::Types::STRUCT, :name => 'ouch', :class => Blublu::InvalidOperation}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class GetFeedPhotos_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          TOKEN = 1
          REQUEST_DATETIME = 2
          SIGN = 3
          SEARCH_PARAM = 4

          FIELDS = {
            TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'},
            REQUEST_DATETIME => {:type => ::Thrift::Types::I64, :name => 'request_datetime'},
            SIGN => {:type => ::Thrift::Types::STRING, :name => 'sign'},
            SEARCH_PARAM => {:type => ::Thrift::Types::STRUCT, :name => 'search_param', :class => Blublu::SearchParam}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class GetFeedPhotos_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          OUCH = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => Blublu::PhotoObject}},
            OUCH => {:type => ::Thrift::Types::STRUCT, :name => 'ouch', :class => Blublu::InvalidOperation}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Test_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          A = 1

          FIELDS = {
            A => {:type => ::Thrift::Types::STRING, :name => 'a'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Test_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class AddImage_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          TOKEN = 1
          REQUEST_DATETIME = 2
          SIGN = 3
          IMAGESTRING = 4
          GROUPID = 5

          FIELDS = {
            TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'},
            REQUEST_DATETIME => {:type => ::Thrift::Types::I64, :name => 'request_datetime'},
            SIGN => {:type => ::Thrift::Types::STRING, :name => 'sign'},
            IMAGESTRING => {:type => ::Thrift::Types::STRING, :name => 'imageString'},
            GROUPID => {:type => ::Thrift::Types::I64, :name => 'groupId'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class AddImage_result
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
