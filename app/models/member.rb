class Member < ActiveRecord::Base
  has_many :invoices, -> { order :created_at, :sent_at }

  scope :active, -> { where left_on: nil }
  scope :left, -> { where 'left_on IS NOT NULL' }

  validates_presence_of :joined_on, :name

  def age(date = Date.today)
    return nil unless birthdate
    age = date.year - birthdate.year
    age -= 1 if date < birthdate + age.years
    age
  end

  def emails
    [email, guardian_1_email, guardian_2_email].reject(&:blank?).map(&:strip)
  end
end
