class Member < ActiveRecord::Base
  scope :active, ->{where left_on: nil}
  scope :left, ->{where 'left_on IS NOT NULL'}

  validates_presence_of :joined_on
end
