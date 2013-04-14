class AddMenuCategoriesToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :menu_categories, :text

  end
end
