class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  layout 'members'

  def new
    @payment = current_wedding.build_payment
  end

  def create
    @payment = current_wedding.build_payment(params[:payment])
    if @payment.save_with_card
      redirect_to edit_payment_path(@payment), :notice => "Thank you!"
    else
      render :new
    end 
  end

  def edit
    @payment = current_wedding.payment
  end

  def update
  end
end
