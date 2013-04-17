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
			#and set a flag
			@select_menu_items=true
			@menubar_categories=Category.find_all_by_id(categories)
		else
			@menubar_categories=Category.all()
		end
		logger.debug "Just got site settings, see? "+@settings.site_name.to_s
	end

	def set_user_time_zone
	  Time.zone = @settings.time_zone
	end
	
	
	def find_posts(return_drafts)
	if return_drafts
		logger.debug "return_drafts exist and true"
	end
		#original query: Blog.find(:all, :conditions=> "isdraft=0", :order=>"created_at desc")
		if (defined? return_drafts) && return_drafts==true && current_user && current_user.is_admin
			logger.debug "returning drafts"
			Blog.find(:all, :order=>"published desc") 	
		else
			logger.debug "not returning drafts"
			Blog.find(:all, :conditions=> "isdraft=0", :order=>"published desc") 	
		end
	end
	
end
