class User < ActiveRecord::Base
  attr_accessible :email, :goal_increment, :name, :oauth_token, :oauth_token_secret, :provider, :uid

  def self.from_omniauth(auth)
    user = User.where(auth.slice(:provider, :uid)).first_or_create
    user.update_attributes name: auth.info.display_name,
                           oauth_token: auth.extra.access_token.params['oauth_token'],
                           oauth_token_secret: auth.extra.access_token.params['oauth_token_secret']
    user
  end

  def fitbit_goal
    FitbitGoal.new(self)
  end

end
