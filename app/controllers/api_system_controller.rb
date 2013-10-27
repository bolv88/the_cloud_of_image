$:.push('./gen-rb')
require 'thrift'
require 'system'

class ApiSystemController < BaseApiController
  def initialize
    super
    self.not_authed_methods = ["_update"]
  end

  def index
    input_buffer = request.raw_post
    output_buffer = StringIO.new

    handler = self

    processor = Blublu::System::Processor.new(handler)

    transport = Thrift::IOStreamTransport.new StringIO.new(input_buffer), output_buffer

    protocol_factory = Thrift::BinaryProtocolFactory.new()
    protocol = protocol_factory.get_protocol transport

    processor.process protocol, protocol

    send_data output_buffer.string
  end



  def getUpdate machine_id, request_time, sign, now_version, system, channel
    if machine_id.length < 10
      self.raise_exception -101
    end
    
    update_info = Blublu::UpdateInfo.new()
    update_info.version = "1.0.0"
    update_info.updateMsg = ""
    update_info.forceUpdate = false
    update_info.downloadUrl = "http://106.187.49.213:8011/CameraMoniter-1.0.0.apk"

    return update_info
  end
end
