class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.integer :caching, :default => 0
      t.string :site_name, :default => "My Blog"
      t.string :time_zone, :default => "Mountain Time (US & Canada)"
      t.text :left_sidebar

      t.timestamps
    end
  end
end
