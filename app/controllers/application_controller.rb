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
	
	
	def find_posts(params)
	#takes what is givien via URL params
	#currently looks for: params[:category], params[:show_drafts]
	#return_drafts, category
	  	logger.debug "url params: "
  	logger.debug "categopry: "+params[:category].to_s
  	logger.debug "shwo draft: "+params[:show_drafts].to_s

	if params[:category] && params[:category] != ""
		category=params[:category]
		logger.debug "set internal category to "+category.to_s
	else
		category="0"
	end
	if params[:show_drafts] && params[:show_drafts] != ""
		return_drafts=params[:show_drafts]
		logger.debug "set internal show_drafts to "+return_drafts.to_s
	end
	logger.debug "cot params: "
	logger.debug "return_drafts: "+return_drafts.to_s
	logger.debug "category: "+category.to_s
	#build query condititons
		#original query: Blog.find(:all, :conditions=> "isdraft=0", :order=>"created_at desc")
		if (defined? return_drafts) && return_drafts=="true" && current_user && current_user.is_admin
			logger.debug "returning drafts"
			query_cond=""
			logger.debug "returning drafts = true, query_cond = "+query_cond.to_s
			#Blog.find(:all, :order=>"published desc") 	
		else
			logger.debug "not returning drafts"
			query_cond="isdraft=0"
			logger.debug "returning drafts = false, query_cond = "+query_cond.to_s
			#Blog.find(:all, :conditions=> "isdraft=0", :order=>"published desc") 	
		end
		if (defined? category) && (category != "0")
			logger.debug "category= "+category.to_s
			@category=Category.find_by_id(category)
			if @category
				@category.blogs.find(:all, :conditions=> query_cond, :order=>"published desc")
			else
				return false
			end
			#logger.debug "category name "+@category.name
		else
			logger.debug "returning category == 0, query_cond = "+query_cond.to_s
			Blog.find(:all, :conditions=> query_cond, :order=>"published desc") 
		end
		#@category.blogs.find(:all, :conditions=> query_cond, :order=>"published desc") 
		#logger.debug "query_cond is "+query_cond
		#Blog.find(:all, :conditions=> query_cond, :order=>"published desc") 	
	end
	
end
