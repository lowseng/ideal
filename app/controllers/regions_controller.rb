class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy]

  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.where(:place_id => params[:m_place_id]).order('name asc') 

  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @regions = Region.where(:place_id => params[:m_place_id]).order('name asc')   
    @rawregions = Region.all.order('updated_at desc') 
  end

  # GET /regions/1/edit
  def edit
    
    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @regions = Region.where(:place_id => params[:m_place_id]).order('name asc') 
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(region_params)
    #@regions & @rawregions added for validates :name, presence: true ELSE error!
    @regions = Region.where(:place_id => params[:m_place_id]).order('name asc')
    @rawregions = Region.all.order('updated_at desc')    
    
    @region.place_id = params[:m_place_id]

    if @region.save
      flash[:success]='New record added'
      redirect_to new_region_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'
      render 'new' 
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    
    if @region.update(region_params)
      flash[:success]='Record updated'
      redirect_to new_region_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'      
      @regions = Region.where(:place_id => params[:m_place_id]).order('name asc')
      @rawregions = Region.all.order('updated_at desc') 
      render 'new' 
    end
  end

  def destroy
    @region.destroy
    flash[:success]='Record removed'
    redirect_to new_region_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_params
      params.require(:region).permit(:name)
    end
end
