json.array!(@members) do |member|
  json.extract! member, :id, :name, :address, :birthdate, :left_on, :postal_code, :post_office, :guardian_1, :guardian_2, :joined_on, :female, :email, :guardian_1_email, :guardian_2_email, :mobile
  json.url member_url(member, format: :json)
end
