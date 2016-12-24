json.array!(@products) do |product|
  json.extract! product, :id, :name, :img, :desc_short, :desc_long
  json.url product_url(product, format: :json)
end
