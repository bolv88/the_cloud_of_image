$:.push('./gen-rb')
require 'thrift'
require 'site_shared_types'
require 'photo_group_head_types'
require './gen-rb/group'

class GroupApiController < BaseApiController
  def initialize
    super
  end

  def index
    input_buffer = request.raw_post
    output_buffer = StringIO.new

    handler = self

    processor = Blublu::Group::Processor.new(handler)

    transport = Thrift::IOStreamTransport.new StringIO.new(input_buffer), output_buffer

    protocol_factory = Thrift::BinaryProtocolFactory.new()
    protocol = protocol_factory.get_protocol transport

    processor.process protocol, protocol

    send_data output_buffer.string
  end

  def _create group_name
    group = Group.new(:name => group_name, :user_id=>13, :status=>1)
    if not group.save
        self.raise_exception -201, group.errors
    end

    #保存自己
    group_user = GroupUser.new(:group_id => group.id, :status=>1, :user_id => self.api_user_id)
    if not group_user.save
        self.raise_exception -201, group_user.errors
    end
    return group.id
  end

  def _searchMyGroup search_param
    group_users = GroupUser.where(:user_id => self.api_user_id).includes(:group)
    rs = []
    group_users.each{|group_user|
        rs << Blublu::GroupInfo.new(:groupId => group_user.group_id, :groupName => group_user.group.name)
    }
    
    return rs

  end
end
