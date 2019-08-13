class Payment < ActiveRecord::Base
  attr_accessor :stripe_card_token, :charge

  belongs_to :wedding

  def card
    charge.card
  end

  def amount
    charge.amount / 100
  end

  def date
    Time.at(charge.created).to_s(:long)
  end

  def charge
    return nil if stripe_charge_id.nil?
    @charge ||= OpenStruct.new Stripe::Charge.retrieve(stripe_charge_id)
  end

  def save_with_card
    if valid?
      plan = Plan.find('simple')
      charge = Stripe::Charge.create(
        amount: plan.amount,
        currency: plan.currency,
        description: wedding_id, 
        card: stripe_card_token
      )
      self.stripe_charge_id = charge.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem processing your credit card, your card was not charged. #{e.message}"
    false
  end
end
