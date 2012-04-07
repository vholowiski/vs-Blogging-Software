class AddBlogImageToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blog_image_id, :integer

  end
end
