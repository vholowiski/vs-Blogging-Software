class Tag < ActiveRecord::Base
	has_many :blog_tags
	has_many :blogs, :through => :blog_tags, :order => 'created_at DESC'
	
	def to_param
	  "#{id}-#{tag.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')}"
	end
end
