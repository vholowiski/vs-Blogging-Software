class Categorization < ActiveRecord::Base
	belongs_to :blog
	belongs_to :category
end
