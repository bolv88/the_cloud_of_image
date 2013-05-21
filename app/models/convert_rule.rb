class ConvertRule < ActiveRecord::Base
  attr_accessible :description, :status, :symbol, :title, :user_id
end
