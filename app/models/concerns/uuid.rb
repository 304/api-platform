module Uuid
  extend ActiveSupport::Concern

  included do
    self.primary_key = 'id'
    before_create :generate_uuid

    def generate_uuid
      self.id ||= SecureRandom.hex(10)
    end
  end
end
