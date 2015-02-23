class Member < ActiveRecord::Base
  scope :active, ->{where left_on: nil}
  scope :left, ->{where 'left_on IS NOT NULL'}

  validates_presence_of :joined_on, :name

  def age(date = Date.today)
    return nil unless birthdate
    age = date.year - birthdate.year
    age -= 1 if date < birthdate + age.years
    age
  end
end
