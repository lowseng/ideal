class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.where(:region_id => params[:m_region_id]).order('name asc') 
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @areas = Area.where(:region_id => params[:m_region_id]).order('name asc') 
    @rawareas = Area.all.order('updated_at desc') 
  end

  # GET /areas/1/edit
  def edit
    # 24-Apr-2016 - To enable merging index to list regions when viewing    
    @areas = Area.where(:region_id => params[:m_region_id]).order('name asc')     
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)
    @area.region_id = params[:m_region_id]
    #@areas & @rawareas added for validates :name, presence: true ELSE error!
    @areas = Area.where(:region_id => params[:m_region_id]).order('name asc')   
    @rawareas = Area.all.order('updated_at desc') 

    if @area.save
      flash[:success]='New record added'      
      redirect_to new_area_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name], :m_region_id => params[:m_region_id], :region_name => params[:region_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'
      render 'new' 
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    if @area.update(area_params)
      flash[:success]='Record updated'
      redirect_to new_area_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name], :m_region_id => params[:m_region_id], :region_name => params[:region_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'      
      #@areas & @rawareas added for validates :name, presence: true ELSE error!
      @areas = Area.where(:region_id => params[:m_region_id]).order('name asc')   
      @rawareas = Area.all.order('updated_at desc')  
      render 'new' 
    end
  end

  def destroy
    @area.destroy
    flash[:success]='Record removed'
    redirect_to new_area_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name], :m_region_id => params[:m_region_id], :region_name => params[:region_name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name)
    end
end
