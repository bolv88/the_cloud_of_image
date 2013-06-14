class SiteController < ApplicationController
  def index
    p params
    p session[:session_id]
  end
end
