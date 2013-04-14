class AddShareThisMobileToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :sharethis_mobile, :text

  end
end
