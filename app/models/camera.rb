class Camera < ActiveRecord::Base
  attr_accessible :image_url, :place, :user_id
end
