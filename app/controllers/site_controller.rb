#coding: utf-8
class SiteController < ApplicationController
  def index
    p params
    p session[:session_id]

    @title = "静态监控"
  end
  def pjax

    if request.headers['X-PJAX']
        render :layout => false
    end
  end
end
