class MembersController < ApplicationController
  before_filter :authenticate_user!
  layout :members
end
