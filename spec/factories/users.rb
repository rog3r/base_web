FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:admin_email) { |n| "admin#{n}@example.com" }
#
  factory :user do
    email #{FactoryGirl.generate(:email)}
    name { Faker::Name.name }
    password 'abc123456'
    password_confirmation 'abc123456'

    # ignore { confirm_user true }

    #factory :admin do
    #  after(:create) {|user| user.add_role(:admin)}
    #end

    #factory :admin do
    #  after(:create) do |user|
    #    user.remove_role(:user)
    #    user.add_role(:admin)
    #  end
    #end

    #factory :superadmin do
    #  after(:create) do |user|
    #    user.remove_role(:user)
    #    user.add_role(:admin)
    #    user.add_role(:superadmin)
    #  end
    #end

    # after(:build) do |object, evaluator|
    # object.skip_confirmation! if evaluator.confirm_user
    # end

    after(:create) do |user|
      #user.confirm!
      user.skip_confirmation!
    end

  end
#
  factory :admin_user, class: User do
    email { FactoryGirl.generate(:admin_email) } #'admin@example.com'
    name 'Admin User'
    password 'abc123456'
    password_confirmation 'abc123456'
    encrypted_password BCrypt::Password.create('abc123456', cost: 10)
    confirmed_at Time.now #Devise Confirmed
  end

  factory :valid_user, class: User do
    email 'valid_user@example.com'
    name 'Valid User Test'
    password 'abc123456'
    password_confirmation 'abc123456'
  end

  factory :unconfirmed_user, class: User do
    email 'unconfirmed_user@example.com'
    name 'Unconfirmed User Test'
    password 'abc123456'
    password_confirmation 'abc123456'
  end

  factory :confirmed_user, class: User do
    email 'confirmed_user@example.com'
    name 'Confirmed User Test'
    password 'abc123456'
    password_confirmation 'abc123456'
    confirmed_at Date.today #Devise Confirmed
  end

  factory :user_default, class: User do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
  end



  ## Pundit Users ---------------------------------------------------------------------------
  factory :administrator, class: User do
   # sequence(:name) { |i| "#{Forgery(:internet).user_name}#{i}" }
    role_id  { create(:admin_role).id }
    email    { Forgery(:email).address }
    password { Forgery(:basic).password(:at_least => 9, :at_most => 10) }
  end

  factory :has_user_authority, class: User do
    sequence(:name) { |i| "#{Forgery(:internet).user_name}#{i}" }
    role_id  { create(:user_role).id }
    email    { Forgery(:email).address }
    password { Forgery(:basic).password(:at_least => 9, :at_most => 10) }
  end

  factory :has_role_authority, class: User do
    sequence(:name) { |i| "#{Forgery(:internet).user_name}#{i}" }
    role_id  { create(:role_role).id }
    email    { Forgery(:email).address }
    password { Forgery(:basic).password(:at_least => 9, :at_most => 10) }
  end

  factory :has_only_view_authority, class: User do
    sequence(:name) { |i| "#{Forgery(:internet).user_name}#{i}" }
    role_id  { create(:only_view_role).id }
    email    { Forgery(:email).address }
    password { Forgery(:basic).password(:at_least => 9, :at_most => 10) }
  end

  ## Fim Pundit Users ---------------------------------------------------------------------------


  # FactoryGirl.create_list(:user, 10)


  #factory :user do
  #  email "john@example.com"
  #  password "secret"
  #  name "John Doe"
  #
  #  trait :no_agent do
  #    role "no_agent"
  #  end
  #
  #  trait :agent do
  #    role "agent"
  #  end
  #
  #  trait :admin do
  #    is_admin true
  #  end
  #
  #end

  #factory :user do
  #  sequence(:username) { |n| "foo#{n}" }
  #  password "foobar"
  #  email { "#{username}@example.com" }
  #end


  #Factory.define :user do |f|
  #  f.sequence(:login) { |n| "user#{n}" }
  #  f.email { |a| "#{a.login}@example.com" }
  #  f.description "Ruby on Rails Developer"
  #end


  # ------------------------- test this hook-------------------------------------
  #Factory.sequence :username do |n|
  #  "user#{n}"
  #end
  #
  ##this factory defines a hacker
  #Factory.define :hacker do |u|
  #  u.username { Factory.next(:username) }
  #end
  # ---------------------------------------------------------------------
end