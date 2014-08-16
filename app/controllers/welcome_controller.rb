class WelcomeController < ApplicationController
  def index
  	 @music = Scrobbler::User.new('reganhsu')

  end

end
