require 'rails_helper'

describe Token do
  it { should belong_to(:user) }

  it { should validate_presence_of(:signature) }
  it { should validate_length_of(:signature).is_at_most(100) }

  it { should validate_presence_of(:user_id) }
  it { should validate_length_of(:user_id).is_at_most(20) }

  it { should validate_presence_of(:expired_at) }
end