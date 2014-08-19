class Track < ActiveRecord::Base
    validates :title, presence: true
    validates :artist, presence: true
end
