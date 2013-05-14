class SearchesController < ApplicationController
  respond_to :json

  def create
    @query = params[:query]
    @invitations = Invitation.search(@query).select('invitations.id,invitations.outer_label')
    render json: @invitations.map{|invitation| {label: invitation.outer_label, path: edit_invitation_path(invitation)}}
  end
end
