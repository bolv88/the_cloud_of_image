class GroupFeed < ActiveRecord::Base
  attr_accessible :feed_type, :group_id, :status, :user_id

  validates_inclusion_of :feed_type, :in => ["apply", "invite"] #3: 正在邀请, 2: 正在申请, 1: 正常, -1: 作废
  validates_inclusion_of :status, :in => [3, 2, 1, -1] #3: 正在邀请, 2: 正在申请, 1: 正常, -1: 作废
  belongs_to :group
  belongs_to :user
end
