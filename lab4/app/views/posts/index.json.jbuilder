json.array!(@posts) do |post|
  json.extract! post, :id, :title, :short_text, :long_text, :img
  json.url post_url(post, format: :json)
end
