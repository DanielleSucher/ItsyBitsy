#!/usr/bin/env ruby

%w(rubygems bundler/setup oauth json yaml).each { |lib| require lib }

class FitbitGoal
  def initialize(type='steps', increment=10)
    @type = type
    @increment = increment
    verify if config['oauth_token'].nil?
  end

  def config
    @config ||= YAML.load_file('env.yml')
  end

  def increment_daily_goal
    if last_run_more_than_one_day_ago
      client.post "#{base_url}/activities/goals/daily.json?type=#{@type}&value=#{old_daily_goal + @increment}",
                  {'Accept-Language' => 'en_US'}
    end
  end

  def verify
    puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{request_token.token} and then enter the verifier code below"
    verifier = gets.chomp

    @access_token = request_token.get_access_token :oauth_verifier => verifier
    save_credentials
  end

  private

    def base_url
      "https://api.fitbit.com/1/user/#{config['user_id']}"
    end

    def client
      @client ||= get_client_from_token_hash
    end

    def consumer
      @consumer ||= OAuth::Consumer.new config['consumer_key'], config['consumer_secret'], site: 'http://api.fitbit.com', request_token_path: '/oauth/request_token'
    end

    def get_client_from_token_hash
      OAuth::AccessToken.from_hash consumer, oauth_token: config['oauth_token'], oauth_token_secret: config['oauth_token_secret']
    end

    def last_run_more_than_one_day_ago
      if @last_run_more_than_one_day_ago = config['last_run'].to_i <= Time.now.to_i - (60 * 60 * 24)
        config['last_run'] = Time.now.to_i
        File.open('env.yml','w') { |f| f.write config.to_yaml }
      end
      @last_run_more_than_one_day_ago
    end

    def old_daily_goal
      response = JSON.parse client.get("#{base_url}/activities/goals/daily.json?type=#{@type}").body
      response['goals'][@type].to_i
    end

    def request_token
      @request_token ||= consumer.get_request_token(callback_url: nil)
    end

    def save_credentials
      config['oauth_token'] = @access_token.token
      config['oauth_token_secret'] = @access_token.secret
      File.open('env.yml','w') { |f| f.write config.to_yaml }
      "Your env.yml config file has been updated!"
    end
end

if __FILE__ == $0
  FitbitGoal.new.increment_daily_goal
end