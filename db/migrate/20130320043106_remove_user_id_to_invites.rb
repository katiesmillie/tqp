class RemoveUserIdToInvites < ActiveRecord::Migration
  def up
    remove_column :invites, :user_id_
      end

  def down
    add_column :invites, :user_id_, :integer
  end
end
