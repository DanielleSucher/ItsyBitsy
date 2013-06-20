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

    def post(resource, args)
      constantize(resource).new(client, base_url).post(args)
    end

    private

      def base_url
        "https://api.fitbit.com/1/user/#{@fitbit_uid}"
      end

      def constantize(resource)
        current_constant = Fitbit
        strings_to_constantize = resource.to_s.split('_').map{|substring| substring.capitalize}
        until strings_to_constantize.empty?
          current_constant = current_constant.const_get strings_to_constantize.shift
        end
        current_constant
      end

      def get_client_from_token_hash
        OAuth::AccessToken.from_hash Fitbit.consumer, oauth_token: @user.oauth_token, oauth_token_secret: @user.oauth_token_secret
      end

  end
end