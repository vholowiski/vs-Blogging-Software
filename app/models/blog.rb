class Blog < ActiveRecord::Base
	belongs_to :user
	has_many :blog_tags
	has_many :tags, :through => :blog_tags
	has_many :categorizations
	has_many :categories, :through => :categorizations
end
