class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :pair_id, :question_id
      t.timestamps
    end
  end
end
