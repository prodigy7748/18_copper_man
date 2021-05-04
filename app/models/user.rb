class User < ApplicationRecord
  has_secure_password(attribute = :password, validations: true)
  has_many :tasks
  validates :email, presence: true, uniqueness: true

  def self.login(u)
    User.find_by(email: u[:email]).try(:authenticate, u[:password])
  end
end
