class AddTypeToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :type, :string
  end
end
