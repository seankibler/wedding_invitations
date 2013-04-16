class PagesController < ApplicationController
  def show
    render :action => request.path_info.gsub('-','_').gsub('/','')
  end
end
