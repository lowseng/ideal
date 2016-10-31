class OneuserController < ApplicationController

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).where(user_id: current_user.id).order('updated_at desc')
  end

  def show
    #@articles = Article.paginate(page: params[:page], per_page: 10).where(user_id: params[:usr]).order('updated_at desc')
    #@oneuser = @articles #for pagination sake!
  end
  
  private

end