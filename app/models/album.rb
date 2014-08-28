class Album < ActiveRecord::Base
	belongs_to :artist
	has_many :articles
	validates_uniqueness_of :title
	
end
