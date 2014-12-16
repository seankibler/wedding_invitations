class PagesController < ApplicationController
  def show
    if requested_page_exists?
      render :action => path_to_template(request.path_info)
    else
      raise ActionController::RoutingError.new "The template #{path_to_template(request.path_info)} does not exist."
    end
  end

  private
  def requested_page_exists?
    File.exist?  "#{Rails.root}/app/views/pages/#{path_to_template(request.path_info)}"
  end

  def path_to_template(path)
    path.gsub('-','_').gsub('/','')
  end
end
