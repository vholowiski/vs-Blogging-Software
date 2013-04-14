class UserController < ApplicationController
	before_filter :authenticate_user!
	
	def settings
		@user=User.find_by_id(current_user.id)
		@categories = Category.all(:order=> 'name') #sort categories alphabetically

	end
	
	def update
		#get the user record
		@user=User.find_by_id(current_user.id)
		#update the approprate fields
		#"user"=>{"first_name"=>"Dave", "last_name"=>"Holowiski", "gplus_url"=>"faring url"}, "commit"=>"Update"}
		if params[:user][:first_name] && params[:user][:first_name] != ""
			logger.debug "saving first name as: "+params[:user][:first_name]
			@user.first_name=params[:user][:first_name]
		end
		if params[:user][:last_name] && params[:user][:last_name] != ""
			logger.debug "saving last name as: "+params[:user][:last_name]
			@user.last_name=params[:user][:last_name]
		end
		if params[:user][:gplus_url] && params[:user][:gplus_url] != ""
			logger.debug "saving gplus: "+params[:user][:gplus_url]
			@user.gplus_url=params[:user][:gplus_url]
		end
		if @user.save
			redirect_to user_settings_path
		end
	end
    
end