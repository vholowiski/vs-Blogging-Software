class AddDisqusToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :disqus_code, :text

  end
end
