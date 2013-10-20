#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Blublu
  class InvalidOperation < ::Thrift::Exception
    include ::Thrift::Struct, ::Thrift::Struct_Union
    WHAT = 1
    WHY = 2

    FIELDS = {
      WHAT => {:type => ::Thrift::Types::I32, :name => 'what'},
      WHY => {:type => ::Thrift::Types::STRING, :name => 'why'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class OperResult
    include ::Thrift::Struct, ::Thrift::Struct_Union
    STATUS = 1
    SUCCESSMSG = 2
    FAILMSG = 3

    FIELDS = {
      STATUS => {:type => ::Thrift::Types::I32, :name => 'status'},
      SUCCESSMSG => {:type => ::Thrift::Types::STRING, :name => 'successMsg'},
      FAILMSG => {:type => ::Thrift::Types::STRING, :name => 'failMsg'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end
