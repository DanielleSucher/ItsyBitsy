class FitbitGoal
  def initialize(user)
    @user = user
    @fitbit_user_id = @user.uid
    @increment = @user.goal_increment
    @type = 'steps'
  end

  def increment_daily_goal
    client.post "#{base_url}/activities/goals/daily.json?type=#{@type}&value=#{old_daily_goal + @increment}",
                {'Accept-Language' => 'en_US'}
  end

  private

    def base_url
      "https://api.fitbit.com/1/user/#{@fitbit_user_id}"
    end

    def client
      @client ||= get_client_from_token_hash
    end

    def consumer
      @consumer ||= OAuth::Consumer.new ENV['FITBIT_CONSUMER_KEY'], ENV['FITBIT_CONSUMER_SECRET'], site: 'http://api.fitbit.com', request_token_path: '/oauth/request_token'
    end

    def get_client_from_token_hash
      OAuth::AccessToken.from_hash consumer, oauth_token: @user.oauth_token, oauth_token_secret: @user.oauth_token_secret
    end

    def old_daily_goal
      response = JSON.parse client.get("#{base_url}/activities/goals/daily.json?type=#{@type}").body
      response['goals'][@type].to_i
    end
end