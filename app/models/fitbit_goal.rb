class FitbitGoal
  def initialize(user)
    @fitbit = Fitbit::Client.new user, user.uid
    @increment = user.goal_increment
    @type = 'steps'
  end

  def increment_daily_goal
    @fitbit.put :daily_goal, type: @type, value: old_daily_goal + @increment
  end

  private

    def old_daily_goal
      @fitbit.get :daily_goal, type: @type
    end
end