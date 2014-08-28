class Artist < ActiveRecord::Base
	has_many :albums 
	has_many :articles
	validates_uniqueness_of :name

end
