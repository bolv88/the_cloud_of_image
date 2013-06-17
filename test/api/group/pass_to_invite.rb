# include thrift-generated code
$:.push('../../../gen-rb')

require 'thrift'
require 'site_shared_types'
require 'photo_group_head_types'
require 'group'

begin
    transport = Thrift::BufferedTransport.new(Thrift::HTTPClientTransport.new("http://localhost:3000/group_api/index"))
    protocol = Thrift::BinaryProtocol.new(transport) 
    client = Blublu::Group::Client.new(protocol)    
    transport.open()    
    testRs = client.passInviteOrApply("1"*11+"#"+"1371199701.193", 123, '123', 5) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

