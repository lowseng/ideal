class UsersController < ApplicationController
  #before_action :authenticate_user!
  before_action :authenticate_user!, :except => [:show]
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy, :hook]
  before_action :require_admin, only: [:destroy, :index]
  before_action :enforce_tenancy, except: [:index]
  
  def index
    if params[:status] == "Premier"
      @users = User.paginate(page: params[:page], per_page: 10).where(:status => params[:status]).order('updated_at desc')
      else if params[:status] == "Pending"
        @users = User.paginate(page: params[:page], per_page: 10).where(:status => [nil,""], gold: true).order('updated_at desc')
        else if params[:status] == "Basic"
          @users = User.paginate(page: params[:page], per_page: 10).where(:status => [nil,""]).order('updated_at desc')
        end
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @places = Place.where(status: true)
    @user = User.find(params[:id]) 
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      if @user.gold?
        if @user.m_gold == "PayPal" #m_gold defined at attr_accessor
          redirect_to @user.paypal_url(paypal_path)
        else 
          if @user.m_gold == "CreditCard"
            redirect_to new_card_path
          else
            redirect_to edit_user_path(current_user.id)
          end
        end 
      else
        #redirect_to 'http://www.yahoo.com'
        redirect_to edit_user_path(current_user.id)
      end
      
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 15)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end
  
  protect_from_forgery except: [:hook]
  def hook
    redirect_to 'http://www.yahoo.com'
  end
  
  private

  def enforce_tenancy
    redirect_to root_path unless session[:m_posting].present?
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :admin, :name, :telephone, :agentno, :company, :preferuom,
        :prefercountry, :gold, :notification_params, :status, :transaction_id, :purchased_at, :m_gold)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    #if current_user != @user and !current_user.admin?
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
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