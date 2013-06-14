class UserToken < ActiveRecord::Base
  attr_accessible :machine_id, :token, :user_id
end
