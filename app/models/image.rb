class Image < ActiveRecord::Base
  attr_accessible :file_id, :file_size, :format, :height, :title, :user_id, :width
end
