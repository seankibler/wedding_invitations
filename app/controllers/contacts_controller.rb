class ContactsController < ApplicationController
  def new
    @contact = Contact.new 
    if request.referrer != request.url
      session[:redirect_to] = request.referrer
    end
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.referrer = session[:redirect_to]
    @contact.user_agent = request.user_agent

    if @contact.save
      flash[:notice] = 'Your message has been sent to us, we will respond shortly if necessary.'
      redirect_to session.delete(:redirect_to) || root_path
    else
      render 'new'
    end
  end
end
