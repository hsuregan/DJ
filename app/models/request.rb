class Request < ActiveRecord::Base
	validates :title, :requester, presence: true
end
