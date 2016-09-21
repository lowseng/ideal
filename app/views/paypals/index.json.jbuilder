json.array!(@paypals) do |paypal|
  json.extract! paypal, :id, :item_number, :invoice
  json.url paypal_url(paypal, format: :json)
end
