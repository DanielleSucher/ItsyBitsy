task :increment_daily_goals => :environment do
  User.all.each { |user| user.fitbit_goal.increment_daily_goal }
end
