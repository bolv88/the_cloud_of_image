class PhotoFeed < ActiveRecord::Base
  attr_accessible :group_id, :photo_id, :status, :user_id
end
