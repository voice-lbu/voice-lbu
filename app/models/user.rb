class User < ActiveRecord::Base
  has_secure_password

  before_validation do
    self.password = 'pass123'
    self.password_confirmation = 'pass123'
  end

  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email, case_sensitive: false

  def authenticate(hash)
    password_digest.split('.').first == hash
  end

  def emails
    [email]
  end
end
