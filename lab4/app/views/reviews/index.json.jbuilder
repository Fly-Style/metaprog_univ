json.array!(@reviews) do |review|
  json.extract! review, :id, :name, :email, :text
  json.url review_url(review, format: :json)
end
