json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password_hash, :password_salt, :phone
  json.url user_url(user, format: :json)
end
