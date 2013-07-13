class CameraPlace < ActiveRecord::Base
  attr_accessible :place, :status
  has_many :cameras
end
