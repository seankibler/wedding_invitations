if File.exists? File.join(Rails.root, 'config', 'stripe.yml')
  stripe_settings = YAML.load(File.open(File.join(Rails.root, 'config', 'stripe.yml')))[Rails.env]

  Stripe.api_key = stripe_settings['api_key']
  STRIPE_PUBLISHABLE_KEY = stripe_settings['publishable_key'] 
end
