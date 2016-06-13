class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @articles = Article.all
    if params[:search]
      @articles = Article.paginate(page: params[:page], per_page: 15).search(params[:search]).order('updated_at desc')
    else
      @articles = Article.paginate(page: params[:page], per_page: 15).order('updated_at desc')      
    end  
    
    @articles = @articles.otherinfo(params[:otherinfo][:name]) if params[:otherinfo].present?

    @places = Place.where(status: true)
    @places_for_dropdown = []
    @places.each do |i|
      @places_for_dropdown << [i.name, i.id]
    end

    @regions = Region.all
    @regions_for_dropdown = []
    @regions.each do |i|
      @regions_for_dropdown << [i.name, i.id, {class: i.place.id}]
   end

    @areas = Area.all
    @areas_for_dropdown = []
    @areas.each do |i|
      @areas_for_dropdown << [i.name, i.id, {class: i.region.id}]
    end
    # END ############# START OTHERINFO ################

    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end
  end

  
end
