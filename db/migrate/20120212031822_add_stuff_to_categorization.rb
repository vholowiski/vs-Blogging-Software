class AddStuffToCategorization < ActiveRecord::Migration
  def change
    add_column :categorizations, :blog_id, :integer

    add_column :categorizations, :category_id, :integer

  end
end
