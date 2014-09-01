class Article < ActiveRecord::Base
	belongs_to :artist
	belongs_to :album 
	validates :author, :content, :rating, presence: true



end
