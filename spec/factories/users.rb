FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:admin_email) { |n| "admin_#{n}@example.com" }
  sequence(:support_email) { |n| "support_#{n}@example.com" }
  sequence(:user_email) { |n| "user_#{n}@example.com" }
  sequence(:guest_email) { |n| "guest_#{n}@example.com" }

  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password 'abc123456'
    password_confirmation 'abc123456'

    trait :with_admin_role do
      email { FactoryGirl.generate(:admin_email) }
      after(:build) do |user|
        user.roles << Role.find_or_create_by(name: 'administrator')
      end
    end

    trait :with_support_role do
      email { FactoryGirl.generate(:support_email) }
      after(:build) do |user|
        user.roles << Role.find_or_create_by(name: 'support')
      end
    end

    trait :with_user_role do
      email { FactoryGirl.generate(:user_email) }
      after(:build) do |user|
        user.roles << Role.find_or_create_by(name: 'user')
      end
    end

    trait :with_guest_role do
      email { FactoryGirl.generate(:guest_email) }
      after(:build) do |user|
        user.roles << Role.find_or_create_by(name: 'guest')
      end
    end

    after(:create) do |user|
      user.skip_confirmation!
    end
  end

end