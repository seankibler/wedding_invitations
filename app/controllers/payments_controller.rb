class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  layout 'members'

  def show
    @payment = current_wedding.payment
  end

  def new
    @payment = current_wedding.build_payment
  end

  def create
    @payment = current_wedding.build_payment(payment_params)
    if @payment.save_with_card
      redirect_to edit_payment_path(@payment), :notice => "Thank you!"
    else
      render :new
    end
  end

  private

  def payment_params
    params[:payment].permit(:stripe_card_token)
  end
end
