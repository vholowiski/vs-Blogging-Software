class Category < ActiveRecord::Base
	has_many :categorizations
	has_many :blogs, :through => :categorizations
end
