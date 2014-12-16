class PagesController < ApplicationController
  def show
    if requested_page_exists?
      render :action => template_from_path
    else
      raise ActionController::RoutingError.new "The template #{template_from_path} does not exist."
    end
  end

  private
  def requested_page_exists?
    template_exists? template_from_path, 'pages'
  end

  def template_from_path
    @template_from_path ||= request.path_info.gsub('-','_').gsub('/','')
  end
end
