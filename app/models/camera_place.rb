class CameraPlace < ActiveRecord::Base
  attr_accessible :place, :status
  has_many :cameras
  validates_uniqueness_of :place, :scope => :user_id

  default_scope where(:status => 1)
end
