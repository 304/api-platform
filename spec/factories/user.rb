FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  trait :with_token do
    after(:create) do |user|
      create(:token, user: user)
    end
  end

end