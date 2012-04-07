class AddBlogImageProperToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blog_image, :integer

  end
end
