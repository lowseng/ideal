class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :enforce_tenancy, except: [:index]
  
  # GET /images
  # GET /images.json
  def index
    #@article = Article.find(session[:current_article])
    @images = Image.all.paginate(page: params[:page], per_page: 90).order('updated_at desc')
    @images1 = Image.where(:article_id => session[:current_article]).order('updated_at desc')  
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    if session[:mpage] == "1"
#  will continue adding images
    else
      redirect_to new_article_path
    end
    @image = Image.new

    if session[:current_article]
      @article = Article.find(session[:current_article])
      @place = Place.find(@article.place)
      @region = Region.find(@article.region)
      @area = Area.find(@article.area)
      @otherinfo = Otherinfo.find(@article.otherinfo) if @article.otherinfo.present? and @article.otherinfo !=""
    else
      redirect_to new_article_path(:param1 => "new")
    end
  end

  # GET /images/1/edit
  def edit

  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.article_id =  session[:current_article]
   #@article = Article.find(@image1.article_idxxxxxxxxxxxxxxxxx)
    respond_to do |format|
      if @image.save
        format.html { redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", :param2 => "value2", anchor: "images"), notice: 'Image was successfully added.' }
        format.json { render :new, status: :created, location: @image1 }
      else
        format.html { redirect_to new_image_path(:param1 => "0", :param2 => "value2"), alert: 'Image was NOT added. Please select a vaild image to upload!' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update

    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    if params[:param1] == "listonly"
      respond_to do |format|
        #format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
        format.html { redirect_to images_path(:param1 => "listonly"), notice: 'Image was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      #redirect_to(:back)
      respond_to do |format|
        format.html { redirect_to edit_article_path(:id => session[:current_article], :param1 => "confirm", anchor: "images"), notice: 'Image was successfully removed.' }
      end
    end
  end

  private
  
    def enforce_tenancy
      redirect_to root_path unless session[:m_posting].present?
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :picture, :article_id)
    end
end
