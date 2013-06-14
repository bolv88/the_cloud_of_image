$:.push('./gen-rb')
require 'thrift'
require 'photos'
require 'photo_group_head_types'
require 'site_shared_types'
require 'user'

class ApiController < ApplicationController
  def raise_exception what,why=''
    what = what.to_s
    conf = {
      "-1" => "请先登陆",
      "-2" => "token错误",
    }
    raise Blublu::InvalidOperation.new(:what=>what.to_i, :why=>conf[what])
  end
  #=tochange, 抛出异常
  def getUserIdByToken token
    tokens = token.split("#")
    if tokens.length < 2
      return self.raise_exception -2
    end

    token = UserToken.where(:machine_id=>tokens[0], :token=>tokens[1]).first

    if not token
      return self.raise_exception -1
    end

    return token.user_id.to_i
  end

  def getUserPhotos token, request_datetime, sign, search_param
    user_id = self.getUserIdByToken token
    
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
    uploader = nil
    original_filename = nil

    images = []
    user = current_user

    f = params[:file]

    uploader = ImageUploader.new
    uploader.store!(f)
    original_filename = f.original_filename
      
    magick = MiniMagick::Image.open(uploader)

    image = Image.new({user_id: user_id, file_size: magick["%b"].to_i, title:params[:uniq_id], file_id:uploader.filename, width:magick[:width], height:magick[:height], format: magick["%m"]})

    image.folder_list = "默认"

    if image.save
      send_data "success"
    else
      send_data "failure"
    end
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

end
