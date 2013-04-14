class AddPlusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gplus_url, :string

  end
end
