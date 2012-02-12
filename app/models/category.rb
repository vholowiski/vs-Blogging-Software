class Category < ActiveRecord::Base
	has_many :categorizations
	has_many :blogs, :through => :categorizations
	
	def to_param
	  "#{id}-#{name.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')}"
	end
end
