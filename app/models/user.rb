class User < ActiveRecord::Base
  include Uuid

  has_secure_password

  validates :name, length: {maximum: 50}, presence: true
  validates :email, length: {maximum: 100}, presence: true, uniqueness: true
  validates :password, length: {maximum: 100}, presence: true

  has_many :tokens

  def token_latest?(token)
    self.tokens.order(created_at: :desc).first == token
  end

end
