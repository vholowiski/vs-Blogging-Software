class Blog < ActiveRecord::Base
	belongs_to :user
	has_many :blog_tags
	has_many :tags, :through => :blog_tags
	has_many :categorizations
	has_many :categories, :through => :categorizations
	belongs_to :blog_image
	
	def to_param
	  "#{id}-#{title.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')}"
	end
end
