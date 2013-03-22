class AddKindToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :kind, :string
  end
  
end
