class RemoveRoundIdFromRounds < ActiveRecord::Migration
  def up
    remove_column :rounds, :round_id
      end

  def down
    add_column :rounds, :round_id, :date
  end
end
