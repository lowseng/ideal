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
  end

  def create 
    @article = Article.new(article_params) #(article_params as a method to whitelist) 
    @article.user = current_user
    
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
    params.require(:article).permit(:title, :description, :proptype, :category, :created_at) 
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