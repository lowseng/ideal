class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    
    @articles = Article.all

    if params[:search]
      @articles = Article.paginate(page: params[:page], per_page: 15).search(params[:search]).order('updated_at desc')
    else
      @articles = Article.paginate(page: params[:page], per_page: 15).order('updated_at desc')      
    end  
    @articles = @articles.place(params[:place][:name]) if params[:place].present? and params[:place][:name] !=""
    @articles = @articles.region(params[:region][:name]) if params[:region].present? and params[:region][:name] !=""
    @articles = @articles.area(params[:area][:name]) if params[:area].present? and params[:area][:name] !=""
    @articles = @articles.category(params[:category]) if params[:category].present? and params[:category] !=""
    @articles = @articles.otherinfo(params[:otherinfo][:name]) if params[:otherinfo].present? and params[:otherinfo][:name] !=""
    @articles = @articles.proptype(params[:proptype]) if params[:proptype].present? and params[:proptype] !=""
    
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
