# include thrift-generated code
$:.push('../../../gen-rb')

require 'thrift'
require 'photos'
require 'user_api'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new("http://localhost:3000/api_user/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::User_api::Client.new(protocol)    
    transport.open()    
    testRs = client.login("1"*11, 123, '123', "bolv88@gmail.com", "1"*8) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

