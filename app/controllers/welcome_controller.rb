class WelcomeController < ApplicationController
  def index
  	 @music = Scrobbler::User.delay.new('reganhsu')
  end

end
