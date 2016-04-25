class PlacesController < ApplicationController
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
      redirect_to new_place_path
    else 
      flash[:danger]='No spaces allowed'
      render 'new'
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    if @place.update(place_params)
      redirect_to new_place_path
    else 
      render 'new' 
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to new_place_url, notice: 'Place was successfully destroyed.' }
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
      params.require(:place).permit(:name)
    end
end
