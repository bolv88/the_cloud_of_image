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



  def regist machine_id, request_time, sign, now_version, system, channel
    if machine_id.length < 10
      self.raise_exception -101
    end
    
    update_info = Blublu::System::UpdateInfo.new()
    update_info.version = "1.0.0"
    update_info.updateMsg = "光荣上架"
    update_info.forceUpdate = false
    update_info.downloadUrl = ""

    return update_info
  end
end
