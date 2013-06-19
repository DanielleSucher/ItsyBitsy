module Fitbit
  module DailyGoal

    def get_daily_goal(type)
      response = JSON.parse client.get("#{base_url}/activities/goals/daily.json?type=#{type}").body
      response['goals'][type].to_i
    end

    def update_daily_goal(type, value)
      client.post "#{base_url}/activities/goals/daily.json?type=#{type}&value=#{value}",
                  {'Accept-Language' => 'en_US'}
    end

  end
end