class AddSocialToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :plusone, :text

    add_column :site_settings, :facebook, :text

  end
end
