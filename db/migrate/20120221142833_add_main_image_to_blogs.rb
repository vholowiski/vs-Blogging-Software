class AddMainImageToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :mainimage_id, :integer

  end
end
