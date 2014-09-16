class Article < ActiveRecord::Base
	belongs_to :artist
	belongs_to :album 
	validates :author, :content, :rating, presence: true

scope :search_by, -> (search_term) { joins('INNER JOIN artists ON articles.artist_id = artists.id  INNER JOIN albums ON articles.album_id = albums.id').where("artists.name ilike ? or albums.title ilike ? or articles.author ilike?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").order("articles.created_at DESC") }

	#scope :search_by, -> (search_term) { joins('INNER JOIN artists ON articles.artist_id = artists.id  INNER JOIN articles.album_id = albums.id').where("articles.title ilike ? or artists.name ilike ? or albums.title ilike ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").order("artists.created_at DESC") }


#read ! http://guides.rubyonrails.org/active_record_querying.html#joining-tables
#read ! http://www.w3schools.com/sql/sql_join.asp
#read ! http://www.w3schools.com/sql/sql_join_inner.asp

end
