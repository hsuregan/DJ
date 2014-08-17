class Track < ActiveRecord::Base
    validates :title, presence: true
    validates :artist, presence: true
    validates :album, presence: true
    validates_uniqueness_of :title
end
