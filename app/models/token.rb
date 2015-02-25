class Token < ActiveRecord::Base
  include Uuid

  before_create :generate_signature
  before_create :set_expire_date

  belongs_to :user

  scope :by_access_id, ->(id) { where(id: id)}

  def generate_signature
    self.signature ||= ApiAuth.generate_secret_key
  end

  def set_expire_date
    self.expired_at = 1.day.from_now
  end

end
