class Image < ActiveRecord::Base
  attr_accessible :file_id, :file_size, :format, :height, :title, :user_id, :width, :status

  validates :user_id, :file_size, :file_id, :format, presence: true

  default_scope where(:status => 1).order('id desc')

  acts_as_taggable
  acts_as_taggable_on :folders, :tags
end
