class WelcomeController < ApplicationController
  respond_to :html, :xml, :json


  def index
  	list_songs
    @request = Request.new
  end


  def list_songs
  	@item = Scrobbler::User.new('reganhsu').recent_tracks.first
    #@item_ucla = Scrobbler::User.new('uclaradio').recent_tracks.first
    @itunes = ITunes::Client.new    

    @recent_tracks = Track.order(updated_at: :desc).limit(10)
    @track = Track.new({"title" => @item.name, 
              "artist" => @item.artist,
              "album" => @item.album})

    #@track_ucla = Track.new({"title" => @item_ucla.name, "artist" => @item_ucla.artist,"album" => @item_ucla.album})
    
    if(@track.artist.include? "amp;")
      @track.artist = @track.artist.delete "amp;"
    end
    
    if(@track.title.include? "amp;")
      @track.title = @track.title.delete "amp;"
    end

    if (Track.last != nil)
      if (@track.title != Track.last.title || @track.artist != Track.last.artist)
        @track.save!
      end
    end

    @item_album_artwork = @itunes.music("#{@track.artist} #{@track.title}").results.first.artwork_url100
    @item_array_size = @item_album_artwork.size

    #@item_album_artwork_ucla = @itunes.music("#{@track_ucla.artist} #{@track_ucla.title}").results
    #@item_array_size_ucla = @item_album_artwork_ucla.size

    @time = Time.new.to_i
    @allowed_time = Track.last.created_at.to_i + 360


    #@item_album_artwork_ucla = @itunes.music("#{@track_ucla.artist} #{@track_ucla.title}").results
    #@item_array_size_ucla = @item_album_artwork_ucla.size

  	 #respond_with(@item)
  	
  end





end
