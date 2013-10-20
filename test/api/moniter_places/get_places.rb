# include thrift-generated code
$:.push('../../../gen-rb')

require 'thrift'
require 'photos'
require 'moniter_places'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new("http://localhost:3000/api_moniter_place/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::MoniterPlaces::Client.new(protocol)    
    transport.open()
    testRs = client.getMyPlaces("11111111ppppppp#1374503963.6962", 123, '123', 0) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

