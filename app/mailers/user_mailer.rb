class UserMailer < ActionMailer::Base
  default :from => 'uclaradio.djhsu@gmail.com'
  
  def welcome_email(user)
      @user = user
      @url = 'http://example.com/login'
      mail(:to => @user.email, :subject => 'Welcome to My Awesome Site')
    end

    def article_email(address) 
    	@address = address
    	mail(:to => @address, :subject => 'Your Article Has Been Selected')
    end

    def written_article
      mail(:to => 'uclaradio.djhsu@gmail.com', :subject => 'Someone has posted an article')
    end

    def recieved_request(address)
      mail(:to=> address, :subject => "You recently posted a request on Ucladj")
    end
end
