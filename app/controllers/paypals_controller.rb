class PaypalsController < ApplicationController
  skip_before_filter :verify_authenticity_token  #to further probe - without gort error ActionController::InvalidAuthenticityToken
  before_action :authenticate_user!
  before_action :set_paypal, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:destroy, :show, :edit, :update]
  
  # GET /paypals
  # GET /paypals.json
  def index
    @paypals = Paypal.paginate(page: params[:page], per_page: 25).order('updated_at desc')
    #@paypals = Paypal.all
  end

  # GET /paypals/1
  # GET /paypals/1.json
  def show
  end

  # GET /paypals/new
  def new
    #@paypal = Paypal.new
    Paypal.create(item_number: params[:item_number], invoice: params[:invoice], m_id: params[:id], quantity: params[:quantity],
        item_name: params[:item_name], mc_currency: params[:mc_currency], mc_gross: params[:mc_gross], mc_fee: params[:mc_fee],
        payment_gross: params[:payment_gross], payment_fee: params[:payment_fee], handling_amount: params[:handling_amount],
        shipping: params[:shipping], tax: params[:tax], payment_status: params[:payment_status], payment_type: params[:payment_type],
        payment_date: params[:payment_date], txn_id: params[:txn_id], txn_type: params[:txn_type], first_name: params[:first_name],
        last_name: params[:last_name], address_name: params[:address_name], address_street: params[:address_street],
        address_city: params[:address_city], address_state: params[:address_state], address_zip: params[:address_zip], 
        address_country: params[:address_country], address_country_code: params[:address_country_code], payer_id: params[:payer_id], 
        payer_email: params[:payer_email], payer_status: params[:payer_status], business: params[:business], 
        receiver_email: params[:receiver_email], receiver_id: params[:receiver_id], residence_country: params[:residence_country],
        user_id: params[:id])

    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @user = User.find params[:id]
      @user.status = "Premier"
      @user.transaction_id = params[:txn_id]
      @user.purchased_at = Time.now
      @user.save
    else
      @user = User.find params[:id]
      @user.gold = false
      @user.save
    end
    redirect_to root_path
  end

  # GET /paypals/1/edit
  def edit
  end

  # POST /paypals
  # POST /paypals.json
  def create
    @paypal = Paypal.new(paypal_params)

    respond_to do |format|
      if @paypal.save
        format.html { redirect_to @paypal, notice: 'Paypal was successfully created.' }
        format.json { render :show, status: :created, location: @paypal }
      else
        format.html { render :new }
        format.json { render json: @paypal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paypals/1
  # PATCH/PUT /paypals/1.json
  def update
    respond_to do |format|
      if @paypal.update(paypal_params)
        format.html { redirect_to @paypal, notice: 'Paypal was successfully updated.' }
        format.json { render :show, status: :ok, location: @paypal }
      else
        format.html { render :edit }
        format.json { render json: @paypal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paypals/1
  # DELETE /paypals/1.json
  def destroy
    @paypal.destroy
    respond_to do |format|
      format.html { redirect_to paypals_url, notice: 'Paypal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paypal
      @paypal = Paypal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paypal_params
      params.require(:paypal).permit(:item_number, :invoice)
    end
    
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
end
