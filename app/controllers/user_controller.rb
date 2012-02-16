class UserController < ApplicationController
	def settings
		@categories = Category.all(:order=> 'name') #sort categories alphabetically

	end
    
end