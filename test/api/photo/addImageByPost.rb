# include thrift-generated code
$:.push('../../../gen-rb')
$:.push('../')

require 'config'
require 'thrift'
require 'photos'
require 'rest_client'

url  = get_base_url + "/api/upload"
token = get_token
time = 123
sign = "123"

posts = {}
posts[:file] = File.open("test.png")
posts[:group_id] = 3
posts[:token] = token

puts RestClient.post(url, posts)

