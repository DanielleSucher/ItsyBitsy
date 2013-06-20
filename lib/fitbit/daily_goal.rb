module Fitbit
  class DailyGoal
    def initialize(client, base_url)
      @client = client
      @base_url = base_url
    end

    def get(args={type: nil})
      response = JSON.parse @client.get("#{@base_url}/activities/goals/daily.json?type=#{args[:type]}").body
      response['goals'][args[:type]].to_i
    end

    def put(args={type: nil, value: nil})
      @client.post "#{@base_url}/activities/goals/daily.json?type=#{args[:type]}&value=#{args[:value]}",
                  {'Accept-Language' => 'en_US'}
    end

  end
end