# include thrift-generated code
$:.push('../../../gen-rb')
$:.push('../')

require 'thrift'
require 'photos'
require 'config'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new(get_base_url+"/api/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::Photos::Client.new(protocol)    
    transport.open()    
    search_param = Blublu::SearchParam.new(:num=>10)
    token = get_token
    testRs = client.getUserPhotos(token, 123, '123', search_param) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

