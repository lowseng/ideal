class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :m_gold
  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :articles, dependent: :destroy
  has_many :paypals, dependent: :destroy
  has_many :cards
  
  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "merchant@windaq.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        #invoice: '229',
        amount: '15.00',
        item_name: 'Premier',
        #item_number: id,
        notify_url: "#{Rails.application.secrets.app_host}/hook",
        quantity: '10'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
  
end
