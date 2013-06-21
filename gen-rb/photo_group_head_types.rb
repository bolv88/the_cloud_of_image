#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#


module Blublu
    class UserInfo
      include ::Thrift::Struct, ::Thrift::Struct_Union
      USERID = 1
      USERNAME = 2

      FIELDS = {
        USERID => {:type => ::Thrift::Types::I64, :name => 'userId'},
        USERNAME => {:type => ::Thrift::Types::STRING, :name => 'userName'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class GroupInfo
      include ::Thrift::Struct, ::Thrift::Struct_Union
      GROUPID = 1
      GROUPNAME = 2
      IFADMINER = 3
      UNREADINFONUMBER = 4
      GROUPUSERS = 5

      FIELDS = {
        GROUPID => {:type => ::Thrift::Types::I64, :name => 'groupId'},
        GROUPNAME => {:type => ::Thrift::Types::STRING, :name => 'groupName'},
        IFADMINER => {:type => ::Thrift::Types::I32, :name => 'ifAdminer'},
        UNREADINFONUMBER => {:type => ::Thrift::Types::I32, :name => 'unReadInfoNumber', :optional => true},
        GROUPUSERS => {:type => ::Thrift::Types::LIST, :name => 'groupUsers', :element => {:type => ::Thrift::Types::STRUCT, :class => Blublu::UserInfo}, :optional => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class GroupFeed
      include ::Thrift::Struct, ::Thrift::Struct_Union
      FEEDID = 1
      GROUPINFO = 2
      TIMESTAMP = 3
      FEEDTYPE = 4
      CREATERINFO = 5

      FIELDS = {
        FEEDID => {:type => ::Thrift::Types::I64, :name => 'feedId'},
        GROUPINFO => {:type => ::Thrift::Types::STRUCT, :name => 'groupInfo', :class => Blublu::GroupInfo},
        TIMESTAMP => {:type => ::Thrift::Types::I64, :name => 'timeStamp'},
        FEEDTYPE => {:type => ::Thrift::Types::STRING, :name => 'feedType'},
        CREATERINFO => {:type => ::Thrift::Types::STRUCT, :name => 'createrInfo', :class => Blublu::UserInfo}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class PhotoObject
      include ::Thrift::Struct, ::Thrift::Struct_Union
      IMAGEID = 1
      THUMBNILSURL = 2
      IMAGEURL = 3
      TITLE = 4
      UPLOADDATETIME = 5
      USERINFO = 6
      WIDTH = 7
      HEIGHT = 8
      GROUPINFO = 9

      FIELDS = {
        IMAGEID => {:type => ::Thrift::Types::I64, :name => 'imageId'},
        THUMBNILSURL => {:type => ::Thrift::Types::STRING, :name => 'thumbnilsUrl'},
        IMAGEURL => {:type => ::Thrift::Types::STRING, :name => 'imageUrl'},
        TITLE => {:type => ::Thrift::Types::STRING, :name => 'title'},
        UPLOADDATETIME => {:type => ::Thrift::Types::I64, :name => 'uploadDateTime'},
        USERINFO => {:type => ::Thrift::Types::STRUCT, :name => 'userInfo', :class => Blublu::UserInfo, :optional => true},
        WIDTH => {:type => ::Thrift::Types::DOUBLE, :name => 'width', :optional => true},
        HEIGHT => {:type => ::Thrift::Types::DOUBLE, :name => 'height', :optional => true},
        GROUPINFO => {:type => ::Thrift::Types::STRUCT, :name => 'groupInfo', :class => Blublu::GroupInfo, :optional => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class SearchParam
      include ::Thrift::Struct, ::Thrift::Struct_Union
      LAST_IMAGE_ID = 1
      NUM = 2
      ORDER_BY = 3
      GROUPID = 4

      FIELDS = {
        LAST_IMAGE_ID => {:type => ::Thrift::Types::I32, :name => 'last_image_id', :optional => true},
        NUM => {:type => ::Thrift::Types::I32, :name => 'num', :optional => true},
        ORDER_BY => {:type => ::Thrift::Types::STRING, :name => 'order_by', :optional => true},
        GROUPID => {:type => ::Thrift::Types::I64, :name => 'groupId', :optional => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class GroupSearchParam
      include ::Thrift::Struct, ::Thrift::Struct_Union
      GROUPNAME = 1
      LASTGROUPID = 2
      ORDERBY = 3
      RESULTCOLUMNS = 4

      FIELDS = {
        GROUPNAME => {:type => ::Thrift::Types::STRING, :name => 'groupName', :optional => true},
        LASTGROUPID => {:type => ::Thrift::Types::I64, :name => 'lastGroupID', :optional => true},
        ORDERBY => {:type => ::Thrift::Types::STRING, :name => 'orderBy', :optional => true},
        RESULTCOLUMNS => {:type => ::Thrift::Types::STRING, :name => 'resultColumns', :optional => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end
