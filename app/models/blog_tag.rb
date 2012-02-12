class BlogTag < ActiveRecord::Base
	belongs_to	:blog
	belongs_to	:tag
	has_many :categorizations
	has_many :categories, :through => :categorizations
end
