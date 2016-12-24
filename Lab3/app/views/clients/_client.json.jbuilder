json.extract! client, :id, :username, :email, :password, :balance, :is_super, :is_book, :created_at, :updated_at
json.url client_url(client, format: :json)