class ConcertReview < ActiveRecord::Base
	belongs_to :artist
	validates :title, :location, :author, :content


end
