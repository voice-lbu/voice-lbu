class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email, case_sensitive: false

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

end
