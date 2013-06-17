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
    testRs = client.inviteToJoin("1"*11+"#"+"1371199701.193", 123, '123', "c@b.com", 3) 
#testRs = client.test("aaa")
    p testRs
rescue
    p $!
end

