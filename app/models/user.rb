class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :articles, dependent: :destroy

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "merchant@windaq.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: '188',
        amount: '23.00',
        item_name: 'premier-gold',
        item_number: id,
        notify_url: "#{Rails.application.secrets.app_host}/hook",
        quantity: '3'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
  
end
