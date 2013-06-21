# include thrift-generated code
$:.push('../../gen-rb')

require 'thrift'
require 'photos'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new("http://localhost:3000/api/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::Photos::Client.new(protocol) 
   
    transport.open() 
   
#testRs = client.getUserPhotos("sdf", 123, '123', search_param) 
#testRs = client.test("aaa")
    imageString = open("/tmp/test.jpg").read
    testRs = client.addImage "pp", 123, 'pp', imageString
    p testRs
rescue
    p $!
end
