class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  #before_action :require_admin, only: [:index]
  before_action :enforce_tenancy, except: [:index, :show]

  def index
#for managed ads(admin) and user's listing only
    if logged_in? 
      if current_user.admin?
        if params[:usr].present?
          @articles = Article.paginate(page: params[:page], per_page: 10).where(xonline: true, user_id: params[:usr]).order('updated_at desc') 
        else
          @articles = Article.paginate(page: params[:page], per_page: 10).order('updated_at desc')              
        end
      else
        if params[:usr].present?
          @articles = Article.paginate(page: params[:page], per_page: 10).where(xonline: true, user_id: params[:usr]).order('updated_at desc')
        else
          @articles = Article.paginate(page: params[:page], per_page: 10).where(user_id: current_user).order('updated_at desc') 
          params[:displayedit] = "Y"
        end
      end
    else  
      @articles = Article.paginate(page: params[:page], per_page: 10).where(xonline: true, user_id: params[:usr]).order('updated_at desc')      
    end
  end

  def new 
# session[:mpage]
# = 0 at welcome/index, articles/new
# = 1 at articles/save, articles/update
# to allow multiple images upload (stay on in images/form)


    session[:mpage] = "0" #init to 0 importatnt
    @article = Article.new 
    @image = @article.images.new
 
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
    # END ############# START OTHERINFO ################

    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end
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
    # END ############# START OTHERINFO ################

    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end

    @article = Article.new(article_params) #(article_params as a method to whitelist) 
    @article.user = current_user

    #Retrieve data from Post Request
    @article.place = params[:place][:name] if params[:place].present?
    @article.region = params[:region][:name] if params[:region].present?
    @article.area = params[:area][:name] if params[:area].present?
    @article.otherinfo = params[:otherinfo][:name] if params[:otherinfo].present?    

    if @article.save 
      #flash[:success]='Article was successfully created' 
      current_article = @article.id
      session[:current_article] = current_article
      session[:mpage] = "SAVE"
      #redirect_to new_image_path(:param1 => "1", :param2 => "value2")
      #redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", :param2 => "value2", anchor: "images")
      redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", :param2 => "value2")

    else 
      render 'new' 
    end 
  end

  def show 
# @articles used to list individual ads for public only
      @articles = Article.paginate(page: params[:page], per_page: 10).where(user_id: params[:usr], xonline: true).order('updated_at desc')    
      @places = Place.find(@article.currency) if @article.currency.present?
      @place = Place.find(@article.place) if @article.place.present?
      @region = Region.find(@article.region) if @article.region.present?
      @area = Area.find(@article.area) if @article.area.present?
      @otherinfo = Otherinfo.find(@article.otherinfo) if @article.otherinfo.present?
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
    # END ############# START OTHERINFO ################

    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end

# below added to include images management below editing article 10-Oct-2016
    @image = Image.new
    session[:mpage] = "1"
    current_article = @article.id
    session[:current_article] = current_article

  end
  
  def update 
    
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
    # END ############# START OTHERINFO ################

    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end
    
#Retrieve data from Post Request (Getting new updated values)
    @article.place = params[:place][:name] if params[:place].present?
    @article.region = params[:region][:name] if params[:region].present?
    @article.area = params[:area][:name] if params[:area].present?
    @article.otherinfo = params[:otherinfo][:name] if params[:otherinfo].present?    


    @image = Image.new
    session[:mpage] = "1"
    current_article = @article.id
    session[:current_article] = current_article

    if @article.update(article_params) 
      #flash[:success]='Article was successfully updated' 
      current_article = @article.id
      session[:current_article] = current_article
      if params[:mmaction1] == "NEXT"
        #redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", :param2 => "value2", anchor: "images")        
        redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", :param2 => "value2")        
      else  
        redirect_to articles_path
      end

    else 
      render 'edit'
    end 
    
  end
  
  def destroy 
    @article.destroy 
    flash[:danger] = "Article was successfully deleted" 
    redirect_to articles_path
  end
  
  private 

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:name, :picture, :article_id)
  end
    
    
  def enforce_tenancy
    redirect_to root_path unless session[:m_posting].present?
  end

  def article_params #(method for whitelisting) 
    params.require(:article).permit(:title, :description, :proptype, :category, :created_at, :place,
    :region, :area, :bedroom, :bathroom, :size, :amount, :uom, :currency, :xlift, :xsqua, :xplay, :xbalc,
    :xgymn, :xmini, :xjogg, :xcabl, :xtenn, :xpark, :xsecu, :xpool, :otherinfo, :size1, :titletype, :xonline,
    :images_attributes => [:picture]) 
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