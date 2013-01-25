class RenameTypeToCategoryInQuestion < ActiveRecord::Migration
  def up 
    rename_column :questions, :type, :category
  end

  def down
  end
end
