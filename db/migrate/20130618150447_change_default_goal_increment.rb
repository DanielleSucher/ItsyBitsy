class ChangeDefaultGoalIncrement < ActiveRecord::Migration
  def change
    change_column :users, :goal_increment, :integer, default: 10
  end
end
