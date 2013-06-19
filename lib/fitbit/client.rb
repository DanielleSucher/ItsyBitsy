module Fitbit
  class Client
    include DailyGoal

    def initialize(user, fitbit_uid)
      @user = user
      @fitbit_uid = fitbit_uid
    end

    def client
      @client ||= get_client_from_token_hash
    end

    private

      def base_url
        "https://api.fitbit.com/1/user/#{@fitbit_uid}"
      end

      def get_client_from_token_hash
        OAuth::AccessToken.from_hash Fitbit.consumer, oauth_token: @user.oauth_token, oauth_token_secret: @user.oauth_token_secret
      end

  end
end