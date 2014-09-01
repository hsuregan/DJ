class Album < ActiveRecord::Base
	belongs_to :artist
	has_many :articles
	validates_uniqueness_of :title

	scope :search_by, -> (search_term) { where("title ilike ?", "%#{search_term}%").order("created_at DESC") }
    # i am able to change the name if I want
    # read more about it here: http://guides.rubyonrails.org/active_record_querying.html#scopes


    def self.search(query)
        where("title like ?", "%#{query}%")
    end	
end
