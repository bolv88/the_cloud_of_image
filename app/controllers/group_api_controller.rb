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
    group = Group.new(:name => group_name, :user_id=>self.api_user_id, :status=>1)
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
    group_users = GroupUser.where(:user_id => self.api_user_id).limit(100).includes(:group)
    rs = []
    group_users.each{|group_user|
      if_adminer = 0
      if_adminer = 1 if group_user.group.user_id == self.api_user_id
      rs << Blublu::GroupInfo.new(:groupId => group_user.group_id, :groupName => group_user.group.name, 
                                    :ifAdminer=>if_adminer)
    }
    
    return rs
  end

  def _search group_name
  end

  def _applyToJoin group_id
    group = Group.where(:id => group_id.to_i).first
    if not group
      return self.raise_exception -3, group_id.to_s
    end

    #用户是否在组中
    if group.group_users.where(:user_id => self.api_user_id).length >= 1
      return 2
    end

    group_feed = GroupFeed.new
    group_feed.group = group
    group_feed.user_id = group.user_id
    group_feed.create_id = self.api_user_id
    group_feed.feed_type = "apply"
    group_feed.status = 2

    if group_feed.save
      return 1
    else
      return -1
    end

    return 1
  end

  def _inviteToJoin email,group_id
    group = Group.where(:id => group_id.to_i).first

    if not group
      return self.raise_exception -3, group_id.to_s
    end
    #是否为群管理员
    if not (group.isadmin? self.api_user_id)
      return self.raise_exception -5
    end

    #用户是否存在
    user = User.where(:email => email).first
    if not user
      return self.raise_exception -4, email
    end

    #用户是否在组中
    if group.group_users.where(:user_id => user.id).length >= 1
      return 2
    end

    group_feed = GroupFeed.new
    group_feed.group = group
    group_feed.user = user
    group_feed.create_id = self.api_user_id
    group_feed.feed_type = "invite"
    group_feed.status = 3

    if group_feed.save
      return 1
    else
      return -1
    end

    return 1
  end

  def _passInviteOrApply resourceId
    group_feed = GroupFeed.find_by_id(resourceId)
    if not group_feed
        return self.raise_exception -202, resourceId
    end

    #当前用户是否 可以处理group_feed 
    if not (group_feed.if_can_progress? self.api_user_id)
        return self.raise_exception -203
    end

    #是否修改状态
    if not group_feed.if_can_change_status?
        return self.raise_exception -204
    end

    #将该用户加入到改组中
    user_id = 0
    if group_feed.feed_type == "invite"
        user_id = self.api_user_id
    else
        user_id = group_feed.create_id
    end
    group_user = GroupUser.new(:group_id => group_feed.group_id, :user_id =>user_id, :status=>1)

    if group_user.save
        group_feed.status = 1
        group_feed.save
        return 1
    else
        #是否已存在
        if GroupUser.where(:user_id => user_id, :group_id => group_feed.group_id).length > 0
            group_feed.status = 1
            group_feed.save
            return 2
        end

        return self.raise_exception -6, group_user.errors
    end
  end

  def _refuseInviteOrApply resourceId
    group_feed = GroupFeed.find_by_id(resourceId)
    if not group_feed
        return self.raise_exception -202, resourceId
    end

    #当前用户是否 可以处理 group_feed 
    if not (group_feed.if_can_progress? self.api_user_id)
        return self.raise_exception -203
    end

    #是否修改状态
    if not group_feed.if_can_change_status?
        return self.raise_exception -204
    end

    #将请求设为无效
    group_feed.status = -2

    if group_feed.save
        return 1
    else
        return self.raise_exception -6, group_feed.errors
    end
  end

end

