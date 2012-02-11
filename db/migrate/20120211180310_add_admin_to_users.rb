class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :integer, :default => 0

    add_column :users, :is_author, :integer, :default => 0

    add_column :users, :is_commentor, :integer, :default => 1

  end
end
