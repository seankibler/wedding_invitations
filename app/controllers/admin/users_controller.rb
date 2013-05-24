class Admin::UsersController < AdminController
  def index
    @users = User.order('created_at DESC')
  end
end
