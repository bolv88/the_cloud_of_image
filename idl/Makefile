all:
	thrift -r -out ../gen-rb/ --gen rb photos.idl
	thrift -r -out ../gen-rb/ --gen rb user_api.idl
	thrift -r -out ../gen-rb/ --gen rb group.idl
	thrift -r -out ../gen-rb/ --gen rb moniter_places.idl
	thrift -r -out ../gen-rb/ --gen rb system.idl
objective-c:
	thrift -r -out /Users/yubo/ios/my_project/blublu_image --gen cocoa:log_unexpected photos.idl
	thrift -r -out /Users/yubo/ios/my_project/blublu_image --gen cocoa:log_unexpected user_api.idl
	thrift -r -out /Users/yubo/ios/my_project/blublu_image --gen cocoa:log_unexpected group.idl

java:
	thrift -r -out /tmp/android --gen java user_api.idl
	thrift -r -out /tmp/android --gen java moniter_places.idl
	thrift -r -out /tmp/android --gen java system.idl
