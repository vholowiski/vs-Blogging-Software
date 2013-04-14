class ApplicationController < ActionController::Base
  protect_from_forgery
  
before_filter :get_site_settings
before_filter :set_user_time_zone

private

	def get_site_settings
		#get site settings
		@settings=SiteSetting.find(:first)
		if !@settings
			#new site, this sets the defaults
			@settings=SiteSetting.new
			@settings.save
		end
		if @settings.menu_categories && @settings.menu_categories != ""
			categories=@settings.menu_categories.split(",").collect{ |s| s.to_i }
			categories.each do |c|
				logger.debug "c "+c.to_s
			end
			@menubar_categories=Category.find_all_by_id(categories)
		else
			@menubar_categories=Category.all()
		end
		logger.debug "Just got site settings, see? "+@settings.site_name.to_s
	end

	def set_user_time_zone
	  Time.zone = @settings.time_zone
	end
end
