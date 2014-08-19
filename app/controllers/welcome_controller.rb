class WelcomeController < ApplicationController
  respond_to :html, :xml, :json


  def index
  	list_songs
  end

  def list_songs
  	 @music = Scrobbler::User.new('reganhsu')
     @ucla = Scrobbler::User.new('uclaradio')

     @recent_tracks = Track.order(updated_at: :desc).limit(5)

  	 @item = @music.recent_tracks.first
     @item_ucla = @ucla.recent_tracks.first

  	 @track = Track.new({"title" => @music.recent_tracks.first.name, 
  	 					"artist" => @music.recent_tracks.first.artist,
  	 					"album" => @music.recent_tracks.first.album})

     if(@track.title != Track.last.title || @track.artist != Track.last.artist)
        @track.save!
      end

  	 respond_with(@item)
  	
  end

end
