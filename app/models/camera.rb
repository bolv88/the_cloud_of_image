class Camera < ActiveRecord::Base
  default_scope order('id DESC')        
  attr_accessible :image_url, :place, :user_id

end
