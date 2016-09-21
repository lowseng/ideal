class CardsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  before_action :authenticate_user!
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:destroy, :show, :edit, :update]
  
  def index
    @cards = Card.paginate(page: params[:page], per_page: 25).order('updated_at desc')

  end

  def new
    @card = Card.new
  end
  
  def create
    @card = Card.new(card_params)
    @card.ip_address = request.remote_ip
    @card.user = current_user
    if @card.save
        if @card.purchase
          render :action => "success"
        else
          render :action => "failure"
        end
    else
      render :action => 'new'
    end
  end  

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Credit Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
 private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:user_id, :ip_address, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification)
    end 
    
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
end
