class Admin::WeddingsController < AdminController
  def index
    @weddings = Wedding.all
  end
end
