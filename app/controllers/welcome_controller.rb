class WelcomeController < ApplicationController
  respond_to :html, :xml, :json


  def index
  	list_songs
    @request = Request.new

  @newsfeed = Article.last(5) + News.last(5) + ConcertReview.last(5) #merges two tables 
  @newsfeed = @newsfeed.sort_by {|obj| obj.updated_at}
  @newsfeed = @newsfeed.last(15).reverse!




=begin -> higher efficiency but drawbacks in that a set of 3 news and 2 articles even if the 3rd article came before one of the 3 news and vice versa
   count = Article.count - 1
    @newsfeed = News.last(3)

    stopper = 0;

    while count >= 0 
      review = Article.all.sort[count]
      if review.approval == true
        @newsfeed.push(review)
        stopper = stopper + 1
      end
      if stopper == 2
        break
      end
      count = count - 1
    end

    @newsfeed = @newsfeed.sort_by { |obj| obj.updated_at }
    @newsfeed.reverse!
=end

    if request.xhr?
      render partial: "refresh"
    else
      render "index"
    end

  end


  def list_songs
  	@item = Scrobbler::User.new('reganhsu').recent_tracks.first
    #@item_ucla = Scrobbler::User.new('uclaradio').recent_tracks.first
    @itunes = ITunes::Client.new    

    @recent_tracks = Track.order(updated_at: :desc).limit(10)

  if @item != nil
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

    @item_album_artwork = @itunes.music("#{@track.artist} #{@track.title}").results
    @item_array_size = @item_album_artwork.size

    #@item_album_artwork_ucla = @itunes.music("#{@track_ucla.artist} #{@track_ucla.title}").results
    #@item_array_size_ucla = @item_album_artwork_ucla.size
  else
    @track = Track.last
  end

    @time = Time.new.to_i

    if Track.count != 0 #resetting the database for tracks warrants this - if/else statement
      @allowed_time = Track.last.created_at.to_i + 360
    else
      @allowed_time = @time
    end


    #@item_album_artwork_ucla = @itunes.music("#{@track_ucla.artist} #{@track_ucla.title}").results
    #@item_array_size_ucla = @item_album_artwork_ucla.size

  	 #respond_with(@item)
  	
  end





end
