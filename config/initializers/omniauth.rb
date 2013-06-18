config = YAML.load_file('env.yml')

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, config['consumer_key'], config['consumer_secret']
end