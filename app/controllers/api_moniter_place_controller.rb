$:.push('./gen-rb')
require 'thrift'
require 'photos'
require 'moniter_places'

class ApiMoniterPlaceController < BaseApiController
  def initialize
    super
    self.not_authed_methods = [""]
  end

  def index
    input_buffer = request.raw_post
    output_buffer = StringIO.new

    handler = self

    processor = Blublu::MoniterPlaces::Processor.new(handler)

    transport = Thrift::IOStreamTransport.new StringIO.new(input_buffer), output_buffer

    protocol_factory = Thrift::BinaryProtocolFactory.new()
    protocol = protocol_factory.get_protocol transport

    processor.process protocol, protocol

    send_data output_buffer.string
  end

  def _getMyPlaces start_num=0
    user = User.find(self.api_user_id)
    places = []

    user.CameraPlaces.each {|place|
      place_info = Blublu::MoniterPlaceInfo.new
      place_info.id = place.id
      place_info.name = place.place
      places << place_info
    }

    p places
    return places
  end

  def _addPlace place_name
    #=todo, 检查重复
    user = User.find(self.api_user_id)
    moniter_place = user.CameraPlaces.new
    moniter_place.place = place_name
    moniter_place.status = 1

    rs = Blublu::OperResult.new

    if moniter_place.save
      rs.status = 1
    else
      rs.status = -1
      rs.failMsg = moniter_place.errors
    end

    return rs
  end

  def _upload place_id, time, bytes
    file_name = Digest::MD5.hexdigest(bytes)

    file_path = "/tmp/#{file_name}.jpg"

    f=open(file_path, "wb") 
    f.puts(bytes) 
    f.close

    f = open(file_path, "rb")
    uploader = ImageUploader.new
    uploader.store!(f)

    @camera = Camera.new
    @camera.image_url = uploader.filename

    @camera.user_id = self.api_user_id
    @camera.camera_place_id = place_id
    @camera.created_at = Time.at(time.to_i)
    @camera.save

    p file_path

    rs = Blublu::OperResult.new
    rs.status = 1
    return rs
  end

  def _getMoniterImages place_ids, max_image_id
    return [] if place_ids.length <= 0
    cameras = Camera.where(:camera_place_id => place_ids, :user_id => self.api_user_id)
    if max_image_id > 0
      cameras = cameras.where("id < #{max_image_id}")
    end
    cameras = cameras.limit(30)

    rs = []
    cameras.each{|camera|
      imageInfo = Blublu::MoniterImage.new
      imageInfo.place_id = camera.camera_place_id
      imageInfo.image_id = camera.id
      imageInfo.image_url = display_image_url(camera.image_url);
      if camera.created_at
        imageInfo.date_time = camera.created_at.getlocal.to_i
      else
        imageInfo.date_time = 0
      end
      rs << imageInfo
    }
    return rs
  end
end

