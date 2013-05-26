class ChangeStripeCustomerTokenToStripeChargeId < ActiveRecord::Migration
  def change
    remove_column :payments, :stripe_customer_token
    add_column :payments, :stripe_charge_id, :string
  end
end
