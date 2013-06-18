class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.integer :goal_increment
      t.string  :provider
      t.string  :uid

      t.timestamps
    end
  end
end
