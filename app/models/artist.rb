class Artist < ActiveRecord::Base
	has_many :albums 
	has_many :articles


end
