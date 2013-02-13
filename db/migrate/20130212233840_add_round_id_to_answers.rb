class AddRoundIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :round_id, :integer
  end
end
