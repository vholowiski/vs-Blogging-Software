class AddSharethisToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :sharethis, :text

  end
end
