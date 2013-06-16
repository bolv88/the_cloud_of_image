class PhotoFeed < ActiveRecord::Base
  attr_accessible :group_id, :photo_id, :status, :user_id
  belongs_to :group
  belongs_to :user
  belongs_to :image, :foreign_key => :photo_id
end
