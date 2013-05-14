class SearchesController < ApplicationController
  respond_to :json

  def create
    @query = params[:query]
    @invitations = Invitation.search(@query).select('invitations.id,invitations.outer_label')
    render json: @invitations.map{|invitation| invitation.outer_label}
  end
end
