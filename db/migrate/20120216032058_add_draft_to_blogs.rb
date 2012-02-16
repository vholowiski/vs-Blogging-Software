class AddDraftToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :isdraft, :integer, :default=>0
  end
end
