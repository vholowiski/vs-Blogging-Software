class AddSharethisHeadToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :sharethis_head, :text

  end
end
