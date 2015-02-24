json.array!(@annual_meetings) do |annual_meeting|
  json.extract! annual_meeting, :id, :start_at, :fee
  json.url annual_meeting_url(annual_meeting, format: :json)
end
