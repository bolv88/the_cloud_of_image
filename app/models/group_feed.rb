class GroupFeed < ActiveRecord::Base
  attr_accessible :feed_type, :group_id, :status, :user_id, :create_id

  validates_inclusion_of :feed_type, :in => ["apply", "invite"] #
  validates_inclusion_of :status, :in => [3, 2, 1, -1, -2] #3: 正在邀请, 2: 正在申请, 1: 通过, -1: 作废, -2: 拒绝
  belongs_to :group
  belongs_to :user
  belongs_to :creater, :class_name => :User, :foreign_key => :create_id

  def if_can_progress? user_id
    if self.user_id == user_id
        return true
    end

    return false
  end

  def if_can_change_status?
    if [3,2].include? self.status
        return true
    end
    return false
  end
end
