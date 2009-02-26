class AddInvisionUserReferenceToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :invision_user_id, :integer
  end

  def self.down
    remove_column :users, :invision_user_id
  end
end
