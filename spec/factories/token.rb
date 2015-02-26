FactoryGirl.define do
  factory :token do
    id { Faker::Number.hexadecimal(10) }
    signature { Faker::Number.hexadecimal(20) }
    expired_at { 1.day.from_now }
  end
end