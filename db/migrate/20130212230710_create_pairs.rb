class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :user1_id, :user2_id

      t.timestamps
    end
  end
end
