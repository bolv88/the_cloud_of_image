class GroupFeed < ActiveRecord::Base
  attr_accessible :feed_type, :group_id, :status, :user_id
end
