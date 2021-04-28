class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_presence_of :password, require: true
  has_secure_token :api_key

  has_secure_password
end
