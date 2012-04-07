class AddUserIdToBlogImages < ActiveRecord::Migration
  def change
    add_column :blog_images, :user_id, :integer

  end
end
