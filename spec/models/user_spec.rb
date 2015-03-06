require 'rails_helper'

describe User do
  it { should have_many(:tokens) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(50) }

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(100) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_most(100) }
end
