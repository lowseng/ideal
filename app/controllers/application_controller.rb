class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :authenticate_user!, :except => [:index]
  helper_method :current_user, :logged_in?

  #def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id] 
  #end

  def logged_in?
    !!current_user 
    #user = User.find_by_email("lowseng@yahoo.com")
    #if user.email == "lowseng@yahoo.com"
    #  user.admin = "true"
    #  user.save
    #end
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end 

  def mobile_search
    session[:mpage] = "0"    
    @articles = Article.all
    if params[:search]
      @articles = Article.paginate(page: params[:page], per_page: 10).search(params[:search]).where(xonline: true).order('updated_at desc')
    else
      @articles = Article.paginate(page: params[:page], per_page: 10).where(xonline: true).order('updated_at desc')      
    end  
    @articles = @articles.place(params[:place][:name]) if params[:place].present? and params[:place][:name] !=""
    @articles = @articles.region(params[:region][:name]) if params[:region].present? and params[:region][:name] !=""
    @articles = @articles.area(params[:area][:name]) if params[:area].present? and params[:area][:name] !=""
    @articles = @articles.category(params[:category]) if params[:category].present? and params[:category] !=""
    @articles = @articles.otherinfo(params[:otherinfo][:name]) if params[:otherinfo].present? and params[:otherinfo][:name] !=""
    @articles = @articles.proptype(params[:proptype]) if params[:proptype].present? and params[:proptype] !=""
    @articles = @articles.titletype(params[:titletype]) if params[:titletype].present? and params[:titletype] !=""

# filter bedrooms
    @temp0 = Chainb.find(params[:chainb][:name].to_i) if params[:chainb].present? and params[:chainb][:name] !=""
    @articles = @articles.where('bedroom >= ?', @temp0.name) if params[:chainb].present? and params[:chainb][:name] !=""
    if params[:chainc].present?
      @temp1 = Chainc.find(params[:chainc][:name].to_i) if params[:chainc][:name].present? and params[:chainc][:name] !=""
      @articles = @articles.where('bedroom <= ?', @temp1.name) if params[:chainc][:name].present? and params[:chainc][:name] !=""
    end
    
# filter bathrooms
    @temp2 = Chainb.find(params[:chainb][:bath].to_i) if params[:chainb].present? and params[:chainb][:bath] !=""
    @articles = @articles.where('bathroom >= ?', @temp2.name) if params[:chainb].present? and params[:chainb][:bath] !=""
    if params[:chainc].present?
      @temp3 = Chainc.find(params[:chainc][:bath].to_i) if params[:chainc][:bath].present? and params[:chainc][:bath] !=""
      @articles = @articles.where('bathroom <= ?', @temp3.name) if params[:chainc][:bath].present? and params[:chainc][:bath] !=""
    end

# filter price
    @temp4 = Chainb.find(params[:chainb][:price].to_i) if params[:chainb].present? and params[:chainb][:price] !=""
    @articles = @articles.where('amount >= ?', @temp4.name) if params[:chainb].present? and params[:chainb][:price] !=""
    if params[:chainc].present?
      @temp5 = Chainc.find(params[:chainc][:price].to_i) if params[:chainc][:price].present? and params[:chainc][:price] !=""
      @articles = @articles.where('amount <= ?', @temp5.name) if params[:chainc][:price].present? and params[:chainc][:price] !=""
    end

# filter land area (Sqft or SqM)
    # @articles = @articles.where("(size >= ? AND uom = ?) AND (size >= ? AND uom = ?)",@temp6.name, "3", @temp6.name*0.092903, "4" )
    # @articles = @articles.where("(size >= ? AND uom = ?)" ,@temp6.name, "3") if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
    # @articles = @articles.where("(size >= ? AND uom = ?)" ,@temp6.name.to_i*0.092903, "4") if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
    # @articles = @articles.where("(size >= ? AND uom = ?)" ,@temp6.name, "4") if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
    # @articles = @articles.where("(size >= ? AND uom = ?)" ,@temp6.name.to_i*0.092903, "3") if params[:chainb][:landarea].present? and  params[:chainb][:landarea] !=""
    # @articles = @articles.where("(size <= ? AND uom = ?)" ,@temp7.name, "3") if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""
    # @articles = @articles.where("(size <= ? AND uom = ?)" ,@temp7.name.to_i*10.7639, "4") if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""
    # @articles = @articles.where("(size <= ? AND uom = ?)" ,@temp7.name, "4") if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""
    # @articles = @articles.where("(size <= ? AND uom = ?)" ,@temp7.name.to_i*10.7639, "3") if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""

    if params[:chainb].present?
      @temp6 = Chainb.find(params[:chainb][:landarea].to_i) if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
    end
    if params[:chaina].present?
      if params[:chaina][:uom]=="3" and params[:chainb].present?
        @articles = @articles.where("(size >= ? AND uom = ?) OR (size >= ? AND uom = ?)",@temp6.name, "3", @temp6.name.to_i*0.092903, "4" ) if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
      end
      if params[:chaina][:uom]=="4" and params[:chainb].present? 
        @articles = @articles.where("(size >= ? AND uom = ?) OR (size >= ? AND uom = ?)",@temp6.name, "4", @temp6.name.to_i*10.7639, "3" ) if params[:chainb][:landarea].present? and params[:chainb][:landarea] !=""
      end
      if params[:chaina][:uom]=="3" and params[:chainc].present?
        @temp7 = Chainc.find(params[:chainc][:landarea].to_i) if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""
        @articles = @articles.where("(size <= ? AND uom = ?) OR (size <= ? AND uom = ?)",@temp7.name, "3", @temp7.name.to_i*10.7639, "4" ) if params[:chainc][:landarea].present? and params[:chainb][:landarea] !=""
      end
      if params[:chaina][:uom]=="4" and params[:chainc].present?
        @temp7 = Chainc.find(params[:chainc][:landarea].to_i) if params[:chainc][:landarea].present? and params[:chainc][:landarea] !=""
        @articles = @articles.where("(size <= ? AND uom = ?) OR (size <= ? AND uom = ?)",@temp7.name, "4", @temp7.name.to_i*0.092903, "3" ) if params[:chainc][:landarea].present? and params[:chainb][:landarea] !=""
      end
    end    

# filter buildup area (Sqft or SqM)
    if params[:chanb].present?
      @temp8 = Chainb.find(params[:chainb][:buildup].to_i) if params[:chainb][:buildup].present? and params[:chainb][:buildup] !=""
    end
    if params[:chaina].present?
      if params[:chaina][:uom]=="3" and params[:chainb].present?
        @articles = @articles.where("(size1 >= ? AND uom = ?) OR (size1 >= ? AND uom = ?)",@temp8.name, "3", @temp8.name.to_i*0.092903, "4" ) if params[:chainb][:buildup].present? and params[:chainb][:buildup] !=""
      end
      if params[:chaina][:uom]=="4" and params[:chainb].present? 
        @articles = @articles.where("(size1 >= ? AND uom = ?) OR (size1 >= ? AND uom = ?)",@temp8.name, "4", @temp8.name.to_i*10.7639, "3" ) if params[:chainb][:buildup].present? and params[:chainb][:buildup] !=""
      end
      if params[:chaina][:uom]=="3" and params[:chainc].present?
        @temp9 = Chainc.find(params[:chainc][:buildup].to_i) if params[:chainc][:buildup].present? and params[:chainc][:buildup] !=""
        @articles = @articles.where("(size1 <= ? AND uom = ?) OR (size1 <= ? AND uom = ?)",@temp9.name, "3", @temp9.name.to_i*10.7639, "4" ) if params[:chainc][:buildup].present? and params[:chainb][:buildup] !=""
      end
      if params[:chaina][:uom]=="4" and params[:chainc].present?
        @temp9 = Chainc.find(params[:chainc][:buildup].to_i) if params[:chainc][:buildup].present? and params[:chainc][:buildup] !=""
        @articles = @articles.where("(size1 <= ? AND uom = ?) OR (size1 <= ? AND uom = ?)",@temp9.name, "4", @temp9.name.to_i*0.092903, "3" ) if params[:chainc][:buildup].present? and params[:chainb][:landarea] !=""
      end
    end
    
# location chained-select    
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

# for otherinfo chained-select tied to Place
    @otherinfos = Otherinfo.all
    @otherinfos_for_dropdown = []
    @otherinfos.each do |i|
      @otherinfos_for_dropdown << [i.name, i.id, {class: i.place.id}]
    end

# for bedrooms and bathrooms where id=1. they share same min and max    
    @roomsmin = Chainb.where(:chaina_id => '1')
    @roomsmin_for_dropdown = []
    @roomsmin.each do |i|
      @roomsmin_for_dropdown << [i.name, i.id, {class: i.chaina.id}]
    end
    @roomsmax = Chainc.all
    @roomsmax_for_dropdown = []
    @roomsmax.each do |i|
      @roomsmax_for_dropdown << [i.name, i.id, {class: i.chainb.id}]
    end 

# for price only where id=2
    @pricemin = Chainb.where(:chaina_id => '2')
    @pricemin_for_dropdown = []
    @pricemin.each do |i|
      @pricemin_for_dropdown << [i.name, i.id, {class: i.chaina.id}]
    end
    @pricemax = Chainc.all
    @pricemax_for_dropdown = []
    @pricemax.each do |i|
      @pricemax_for_dropdown << [i.name, i.id, {class: i.chainb.id}]
    end     
    
# for SqFt build-up area only where id=3
    @buildupmin = Chainb.where(:chaina_id => '3')
    @buildupmin_for_dropdown = []
    @buildupmin.each do |i|
      @buildupmin_for_dropdown << [i.name, i.id, {class: i.chaina.id}]
    end
    @buildupmax = Chainc.all
    @buildupmax_for_dropdown = []
    @buildupmax.each do |i|
      @buildupmax_for_dropdown << [i.name, i.id, {class: i.chainb.id}]
    end 

# for Sqft and SqM UOM where id=3 and id=4
    #@uoms = Chaina.where(status: true)
    @uoms = Chaina.find([3,4])
    @uoms_for_dropdown = []
    @uoms.each do |i|
      @uoms_for_dropdown << [i.name, i.id]
    end
    @buildupmin = Chainb.all
    @buildupmin_for_dropdown = []
    @buildupmin.each do |i|
      @buildupmin_for_dropdown << [i.name, i.id, {class: i.chaina.id}]
    end
    @buildupmax = Chainc.all
    @buildupmax_for_dropdown = []
    @buildupmax.each do |i|
      @buildupmax_for_dropdown << [i.name, i.id, {class: i.chainb.id}]
    end       
  end
  
end
