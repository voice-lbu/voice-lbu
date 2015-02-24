class AnnualMeeting < ActiveRecord::Base
  validates_presence_of :start_at
end
