class SiteController < ApplicationController
  def index
    p params
    p session[:session_id]

  end
  def pjax

    if request.headers['X-PJAX']
        render :layout => false
    end
  end
end
