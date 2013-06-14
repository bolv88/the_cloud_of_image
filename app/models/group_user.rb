class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :status, :user_id
  validates_uniqueness_of :user_id, :scope => :group_id
  validates_inclusion_of :status, :in => [3, 2, 1, -1] #3: 正在邀请, 2: 正在申请, 1: 正常, -1: 作废

  default_scope where(:status => 1).order('id desc')

  belongs_to :group
  belongs_to :user

end
