class Group < ActiveRecord::Base
  attr_accessible :name, :status, :user_id
  validates_uniqueness_of :name, :scope => :user_id
  validates_inclusion_of :status, :in => [1,-1] #1: 正常, -1: 作废

  default_scope where(:status => 1).order('id desc')

  has_many :group_users

  def isadmin? user_id
    if self.user_id == user_id
      return true
    end

    return false
  end
end
