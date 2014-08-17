class WelcomeController < ApplicationController
  respond_to :html, :xml, :json


  def index
  	list_songs
  end

  def list_songs
  	 @music = Scrobbler::User.new('reganhsu')
  	 @item = @music.recent_tracks.first
  	 @track = Track.new({"title" => @music.recent_tracks.first.name, 
  	 					"artist" => @music.recent_tracks.first.artist,
  	 					"album" => @music.recent_tracks.first.album})
  	 respond_with(@item)
  	
  end

end
