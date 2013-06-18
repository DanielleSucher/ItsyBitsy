class User < ActiveRecord::Base
  attr_accessible :email, :goal_increment, :name, :oauth_token, :oauth_token_secret, :provider, :uid

  def self.from_omniauth(auth)
    if user = User.find_by_uid(auth.uid)
      user.name = auth.info.display_name
      user.oauth_token = auth.extra.access_token.params['oauth_token']
      user.oauth_token_secret = auth.extra.access_token.params['oauth_token_secret']
      user.save!
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.name = auth.info.display_name
        user.oauth_token = auth.extra.access_token.params['oauth_token']
        user.oauth_token_secret = auth.extra.access_token.params['oauth_token_secret']
        user.provider = auth.provider
        user.uid = auth.uid
      end
    end
  end

  def fitbit_goal
    FitbitGoal.new(self)
  end

end
