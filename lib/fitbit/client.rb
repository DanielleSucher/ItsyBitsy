module Fitbit
  class Client
    def initialize(user, fitbit_uid)
      @user = user
      @fitbit_uid = fitbit_uid
    end

    def client
      @client ||= get_client_from_token_hash
    end

    def get(resource, args)
      constantize(resource).new(client, base_url).get(args)
    end

    def put(resource, args)
      constantize(resource).new(client, base_url).put(args)
    end

    private

      def base_url
        "https://api.fitbit.com/1/user/#{@fitbit_uid}"
      end

      def constantize(resource)
        Fitbit.const_get resource.to_s.split('_').map{|substring| substring.capitalize}.join
      end

      def get_client_from_token_hash
        OAuth::AccessToken.from_hash Fitbit.consumer, oauth_token: @user.oauth_token, oauth_token_secret: @user.oauth_token_secret
      end

  end
end