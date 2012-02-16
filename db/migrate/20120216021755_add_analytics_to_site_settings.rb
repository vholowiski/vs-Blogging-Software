class AddAnalyticsToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :analytics, :text

  end
end
