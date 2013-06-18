class User < ActiveRecord::Base
  attr_accessible :email, :goal_increment, :oauth_token, :oauth_token_secret, :provider, :uid

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.extra.access_token.params['oauth_token']
      user.oauth_token_secret = auth.extra.access_token.params['oauth_token_secret']
    end
  end

  def fitbit_goal
    FitbitGoal.new(self)
  end

end
