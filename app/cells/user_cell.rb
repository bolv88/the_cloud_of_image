class UserCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper_method :current_user, :user_signed_in? #all your needed helper

  def menu
    render
  end

end
