class Admin::ContactsController < AdminController
  respond_to :html

  def index
    @contacts = Contact.order('created_at ASC')
    respond_with @contacts
  end

  def show
    @contact = Contact.find(params[:id])
    respond_with @contact
  end
end
