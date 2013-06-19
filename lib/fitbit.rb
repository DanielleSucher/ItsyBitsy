module Fitbit
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
  end

  def self.consumer
    @consumer ||= OAuth::Consumer.new config.consumer_key, config.consumer_secret, site: 'http://api.fitbit.com', request_token_path: '/oauth/request_token'
  end

  class Configuration
    attr_accessor :consumer_key, :consumer_secret
  end
end