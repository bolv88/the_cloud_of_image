#coding: utf-8
$:.push('./gen-rb')
require 'thrift'
require 'photos'
require 'photo_group_head_types'
require 'site_shared_types'
require 'user'

class ApiController < BaseApiController

  def _getUserPhotos search_param
    user_id = self.api_user_id
    
    #=todo, change user_id
    images = Image.where(:user_id => user_id)

    if (search_param.last_image_id) 
      last_id = search_param.last_image_id.to_i
      if last_id > 0
        images = images.where("id < #{last_id}")
      end
    end
    number = search_param.num.to_i

    if number <= 0 or number > 50
      number = 10
    end

    images = images.limit(number)

    rs = []

    images.each do |image|
      blublu_photo = Blublu::PhotoObject.new(
        :imageId => image.id,
        :imageUrl => display_image_url(image.file_id), 
        :uploadDateTime => image.created_at.tv_sec,
        :width => image.width,
        :height =>image.height)
      rs << blublu_photo
    end

    return rs
  end

  def index
    input_buffer = request.raw_post
    output_buffer = StringIO.new

    handler = self

    processor = Blublu::Photos::Processor.new(handler)

    transport = Thrift::IOStreamTransport.new StringIO.new(input_buffer), output_buffer

    protocol_factory = Thrift::BinaryProtocolFactory.new()
    protocol = protocol_factory.get_protocol transport

    processor.process protocol, protocol

    send_data output_buffer.string
  end

  def display_url id
    display_image_url id
  end
    
  def upload
    user_id = self.getUserIdByToken params[:token]

    if not user_id
        send_data "need_login"
        return
    end

    uploader = nil
    original_filename = nil
    group_id = params[:group_id].to_i

    if group_id >0
      ts = GroupUser.where(:group_id => group_id, :user_id => user_id)
      if ts.length <= 0
        send_data "user not in group"
        return
      end
    end

    if group_id <= 0
      group_id = nil
    end

    images = []
    user = current_user

    f = params[:file]

    #图片存储
    uploader = ImageUploader.new
    uploader.store!(f)
    original_filename = f.original_filename
      
    magick = MiniMagick::Image.open(uploader)

    image = Image.new({user_id: user_id, file_size: magick["%b"].to_i, title:params[:uniq_id], file_id:uploader.filename, width:magick[:width], height:magick[:height], format: magick["%m"]})

    image.folder_list = "默认"

    if not image.save
      send_data "failure"
      return
    end
    

    #加入群组中的每个人
    user_ids = []
    if group_id.to_i > 0
      group_users = GroupUser.where(:group_id => group_id.to_i)
      group_users.each {|group_user|
        user_ids << group_user.user_id
      }
    else
      user_ids << user_id
    end

    user_ids.each{|feed_user_id|
      photo_feed = PhotoFeed.new(:group_id => group_id, :user_id => feed_user_id, :photo_id=>image.id, :status=>1)
      if not photo_feed.save
        send_data "failure"
        return
      end
    }

    send_data "success"
  end

  def test a
    return a
  end

  def addImage token, request_datetime, sign, image_string
    begin
      magick = MiniMagick::Image.read(image_string)

      uploader = ImageUploader.new
      uploader.store!(magick)

      image = Image.new({user_id: 123, file_size: magick["%b"].to_i, title:'hehe', file_id:uploader.filename, width:magick[:width], height:magick[:height], format: magick["%m"]})

      image.folder_list = "默认"

      image.save
      return "success"
    rescue
      p $!
      return "failure"
    end
  end

  def _getFeedPhotos search_param
    
    user_id = self.api_user_id
    
    feeds = PhotoFeed.includes(:image, :group).where(:user_id => user_id)

    if (search_param.last_image_id) 
      last_id = search_param.last_image_id.to_i
      if last_id > 0
        feeds = feeds.where("photo_id < #{last_id}")
      end
    end
    number = search_param.num.to_i

    if number <= 0 or number > 50
      number = 10
    end

    feeds = feeds.limit(number)

    rs = []

    feeds.each do |feed|
      image = feed.image
      blublu_photo = Blublu::PhotoObject.new(
        :imageId => image.id,
        :imageUrl => display_image_url(image.file_id), 
        :uploadDateTime => feed.created_at.tv_sec,
        :width => image.width,
        :height =>image.height,
        )

      if feed.group
        blublu_photo.groupInfo = Blublu::GroupInfo.new
        blublu_photo.groupInfo.groupId = feed.group.id
        blublu_photo.groupInfo.groupName = feed.group.name
      end

      rs << blublu_photo
    end

    return rs
  end
end
