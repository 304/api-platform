class Token < ActiveRecord::Base
  include Uuid

  before_create :generate_signature
  before_create :set_expire_date

  validates :signature, length: {maximum: 100}, presence: true
  validates :user_id, length: {maximum: 20}, presence: true
  validates :expired_at, presence: true

  belongs_to :user

  scope :by_user, ->(user) { where(user: user) }
  scope :desc, -> { order(created_at: :desc) }
  scope :last_token_for, ->(user) { by_user(user).desc.first }

  def generate_signature
    self.signature ||= ApiAuth.generate_secret_key
  end

  def set_expire_date
    self.expired_at ||= 1.day.from_now
  end

end
