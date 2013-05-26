class Plan
  PLANS = {simple: {amount: 1000}}
  attr_reader :amount

  def initialize(plan_id)
    plan = PLANS[plan_id.to_sym]
    @amount = plan[:amount]
  end

  def self.find(plan_id)
    new(plan_id)
  end

  def currency
    'usd'
  end
end
