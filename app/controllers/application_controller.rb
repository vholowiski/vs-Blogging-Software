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
		logger.debug "Just got site settings, see? "+@settings.site_name.to_s
	end

	def set_user_time_zone
	  Time.zone = @settings.time_zone
	end
end
