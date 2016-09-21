class Card < ActiveRecord::Base
  belongs_to :user
  #has_many :card_transactions
  #has_many :transactions, :class_name => "CardTransaction" #must has_many for def purchase to work!
  has_one :card_transaction #must has_many for def purchase to work!  
  attr_accessor :card_number, :card_verification

  #validate_on_create :validate_card - removed after rails 2.0.
  validate :validate_card, :on => :create

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    #transaction.create!(:action => "purchase",  :amount => price_in_cents, :response => response)
    create_card_transaction(action: "purchase", amount: price_in_cents, response: response)

    user.update_attribute(:purchase_at, Time.now) if response.success?
    response.success?
  end
  
  def price_in_cents
    #(user.total_price*100).round
    12345
  end
  
  private

  def purchase_options
    {
        ip: ip_address,
        billing_address: {
            name:      "Winda",
            address1:  "Sdnbhd",
            city:      "Kuala Lumpur",
            state:     "SE",
            country:   "MY",
            zip:       "47500"
        }
    }
  end

  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add :base, message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        type:                card_type,
        number:              card_number,
        verification_value:  card_verification,
        month:               card_expires_on.month,
        year:                card_expires_on.year,
        first_name:          first_name,
        last_name:           last_name
    )
  end
end
