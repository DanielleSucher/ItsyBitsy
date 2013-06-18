Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['FITBIT_CONSUMER_KEY'], ENV['FITBIT_CONSUMER_SECRET']
end