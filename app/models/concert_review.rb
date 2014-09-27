class ConcertReview < ActiveRecord::Base
	belongs_to :artist
	validates :title, :location, :author, :content, presence: true

	scope :search_by, -> (search_term) { joins('INNER JOIN artists ON concert_reviews.artist_id = artists.id').where("artists.name ilike ? or concert_reviews.author ilike ? or concert_reviews.location ilike ? or concert_reviews.title ilike ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").order("concert_reviews.created_at DESC") }

end
