class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  protected
  def render_404
    render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found
    return

    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found }
    end
  end
end
