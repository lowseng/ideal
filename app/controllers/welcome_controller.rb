class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :mmindex]

  before_action :mobile_search #stored in application controller

  def mmindex
  params[:donotdisplay] = "Y" 
    session[:mobile] = "Y"  
  end
  def index
      params[:donotdisplay] = "Y" 
    session[:mobile] = "N"  
  end
end
