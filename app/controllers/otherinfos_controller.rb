class OtherinfosController < ApplicationController
  before_action :set_otherinfo, only: [:show, :edit, :update, :destroy]

  # GET /otherinfos
  # GET /otherinfos.json
  def index
    @otherinfos = Otherinfo.where(:place_id => params[:m_place_id]).order('name asc') 

  end

  # GET /otherinfos/1
  # GET /otherinfos/1.json
  def show
  end

  # GET /otherinfos/new
  def new
    @otherinfo = Otherinfo.new
    # 24-Apr-2016 - To enable merging index to list otherinfos when viewing    
    @otherinfos = Otherinfo.where(:place_id => params[:m_place_id]).order('name asc')   
    @rawotherinfos = Otherinfo.all.order('updated_at desc') 
  end

  # GET /otherinfos/1/edit
  def edit
    
    # 24-Apr-2016 - To enable merging index to list otherinfos when viewing    
    @otherinfos = Otherinfo.where(:place_id => params[:m_place_id]).order('name asc') 
  end

  # POST /otherinfos
  # POST /otherinfos.json
  def create
    @otherinfo = Otherinfo.new(otherinfo_params)

    @otherinfos = Otherinfo.where(:place_id => params[:m_place_id]).order('name asc')
    @rawotherinfos = Otherinfo.all.order('updated_at desc')    
    
    @otherinfo.place_id = params[:m_place_id]

    if @otherinfo.save
      flash[:success]='New record added'
      redirect_to new_otherinfo_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'
      render 'new' 
    end
  end

  # PATCH/PUT /otherinfos/1
  # PATCH/PUT /otherinfos/1.json
  def update
    
    if @otherinfo.update(otherinfo_params)
      flash[:success]='Record updated'
      redirect_to new_otherinfo_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
    else 
      flash[:danger]='Denied. Record existed or spaces entered'      
      @otherinfos = Otherinfo.where(:place_id => params[:m_place_id]).order('name asc')
      @rawotherinfos = Otherinfo.all.order('updated_at desc') 
      render 'new' 
    end
  end

  def destroy
    @otherinfo.destroy
    flash[:success]='Record removed'
    redirect_to new_otherinfo_path(:m_place_id => params[:m_place_id], :country_name => params[:country_name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_otherinfo
      @otherinfo = Otherinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def otherinfo_params
      params.require(:otherinfo).permit(:name)
    end
end
