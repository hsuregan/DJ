class Artist < ActiveRecord::Base
	has_many :albums 
	has_many :articles
	has_many :concert_reviews
	validates_uniqueness_of :name

	scope :search_by, -> (search_term) { where("name ilike ?", "%#{search_term}%").order("created_at DESC") }
    # i am able to change the name if I want
    # read more about it here: http://guides.rubyonrails.org/active_record_querying.html#scopes


    def self.search(query)
        where("name like ?", "%#{query}%")
    end

end
