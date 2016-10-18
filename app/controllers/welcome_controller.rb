class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :mmindex]
  before_action :mobile_search
  
  def mmindex
    session[:mobile] = "Y"  
  end
  def index

  end
end
