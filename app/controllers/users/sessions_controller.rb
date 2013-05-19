class Users::SessionsController < Devise::SessionsController
  def new
    @hh = "hehe"
    render :layout => "brief.html.erb"
  end
end
