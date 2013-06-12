# include thrift-generated code
$:.push('../../gen-rb')

require 'thrift'
require 'photos'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new("http://localhost:3000/api/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::Photos::Client.new(protocol)    
    transport.open()    
    search_param = Blublu::SearchParam.new(:page_num=>10)
    testRs = client.getUserPhotos("sdf", 123, '123', search_param) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

