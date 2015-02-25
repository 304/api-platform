class Token < ActiveRecord::Base
  include Uuid

  before_create :generate_signature
  before_create :set_expire_date

  belongs_to :user

  def generate_signature
    self.signature ||= SecureRandom.hex(30)
  end

  def set_expire_date
    self.expired_at = 1.day.from_now
  end

end
