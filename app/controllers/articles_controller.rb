class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:index]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order('updated_at desc')
  end

  def new 
    @article = Article.new 

    # creating data arrays for selects
    ##################################
    #@places = Place.all
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
    # END #############################

  end

  def create 

    # creating data arrays for selects
    ##################################
    #@places = Place.all
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
    # END #############################


    @article = Article.new(article_params) #(article_params as a method to whitelist) 
    @article.user = current_user

    #Retrieve data from Post Request
    @article.place = params[:place][:name] if params[:place].present?
    @article.region = params[:region][:name] if params[:region].present?
    @article.area = params[:area][:name] if params[:area].present?
    
    if @article.save 
      flash[:success]='Article was successfully created' #Application.html.erb 
      #redirect_to article_path(@article) #Show.hrml.erb 
      current_article = @article.id
      session[:current_article] = current_article
      #redirect_to images_path
      redirect_to new_image_path(:param1 => "value1", :param2 => "value2")
    else 
      render 'new' 
    end 
  end

  def show 

  end
  
  def edit 
    # creating data arrays for selects
    ##################################
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
    # END #############################
  end
  
  def update 
    if @article.update(article_params) 
      flash[:success]='Article was successfully updated' 
      redirect_to article_path(@article)
    else 
      render 'edit'
    end 
  end
  
  def destroy 
    @article.destroy 
    flash[:danger] = "Article was successfully deleted" 
    redirect_to oneuser_index_path
  end
  
  private 
  def article_params #(method for whitelisting) 
    params.require(:article).permit(:title, :description, :proptype, :category, :created_at, :place, :region, :area, :bedroom, :bathroom, :size, :amount, :uom, :currency) 
  end 
  
  def set_article 
    @article = Article.find(params[:id]) 
  end 
  
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end 