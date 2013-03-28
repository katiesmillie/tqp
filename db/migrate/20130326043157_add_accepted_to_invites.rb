class AddAcceptedToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :accepted, :boolean
  end
end
