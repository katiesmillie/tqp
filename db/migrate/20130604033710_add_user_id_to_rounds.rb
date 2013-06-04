class AddUserIdToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :user_id, :integer
  end
end
