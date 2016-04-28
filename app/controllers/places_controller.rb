class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
    #@places = Place.paginate(page: params[:page], per_page: 5)
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new

    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @places = Place.all.order('name asc') 
  end

  # GET /places/1/edit
  def edit
    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @places = Place.all.order('name asc') 
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)
    
    #@place added for validates :name, presence: true ELSE error!
    @places = Place.all.order('name asc') 
    
    if @place.save
      flash[:success]='New record added'
      redirect_to new_place_path
    else 
      flash[:danger]='Denied. Record existed or spaces entered'
      render 'new'
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    if @place.update(place_params)
      flash[:success]='Record updated'
      redirect_to new_place_path
    else 
      flash[:danger]='Denied. Record existed or spaces entered'      
      @places = Place.all.order('name asc') 
      render 'new' 
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to new_place_url, notice: 'Country was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :status, :currency)
    end
    
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
end
