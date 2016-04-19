class OneuserController < ApplicationController

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).where(user_id: current_user.id).order('updated_at desc')
  end

  def forsale
    @articles = Article.paginate(page: params[:page], per_page: 5).where(:proptype => 'for Sale').order('updated_at desc')     
  end
  
  def tolet
    @articles = Article.paginate(page: params[:page], per_page: 5).where(:proptype => 'for Rent').order('updated_at desc')    
  end  
 
  def forauction
    @articles = Article.paginate(page: params[:page], per_page: 5).where(:proptype => 'for Auction').order('updated_at desc') 
  end  
  
  private

end