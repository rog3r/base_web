FactoryGirl.define do

  factory :admin_role, class: Role do
    name 'administrator'
    after(:build) do |admin_role|
      #admin_role.abilities <<   Ability.find_or_initialize_by(domain: 'admin', ability: 'admin')
      #admin_role.abilities << FactoryGirl.find_or_create(:ability_admin_admin) # FactoryGirl.build_stubbed(:ability_admin_admin)
      admin_role.abilities << Ability.find_by(domain: 'admin', ability: 'admin') || FactoryGirl.create(:ability_admin_admin) # FactoryGirl.build_stubbed(:ability_admin_admin)
    end
  end


  # factory :support_role, class: Role do
  #   name 'support'
  #   after(:build) do |support_role|
  #     [FactoryGirl.find_or_create(:ability_user_index),
  #      FactoryGirl.find_or_create(:ability_user_show),
  #      FactoryGirl.find_or_create(:ability_user_create),
  #      FactoryGirl.find_or_create(:ability_user_update),
  #      FactoryGirl.find_or_create(:ability_user_destroy),
  #      FactoryGirl.find_or_create(:ability_role_index),
  #      FactoryGirl.find_or_create(:ability_role_show),
  #      FactoryGirl.find_or_create(:ability_role_update),
  #      FactoryGirl.find_or_create(:ability_role_update),
  #      FactoryGirl.find_or_create(:ability_role_destroy)].each do |ability|
  #       support_role.abilities << ability
  #     end
  #   end
  # end
  #
  # factory :user_role, class: Role do
  #   name 'user'
  #   after(:build) do |support_role|
  #     [FactoryGirl.find_or_create(:ability_user_index),
  #      FactoryGirl.find_or_create(:ability_user_show),
  #      FactoryGirl.find_or_create(:ability_user_create),
  #      FactoryGirl.find_or_create(:ability_user_update),
  #      FactoryGirl.find_or_create(:ability_user_destroy)].each do |ability|
  #       support_role.abilities << ability
  #     end
  #   end
  # end


  factory :user_role, class: Role do
    name 'user'
    after(:build) do |user_role|
      [Ability.find_by(domain: 'user', ability: 'index')   || FactoryGirl.create(:ability_user_index),
       Ability.find_by(domain: 'user', ability: 'show')    || FactoryGirl.create(:ability_user_show),
       Ability.find_by(domain: 'user', ability: 'create')  || FactoryGirl.create(:ability_user_create),
       Ability.find_by(domain: 'user', ability: 'update')  || FactoryGirl.create(:ability_user_update),
       Ability.find_by(domain: 'user', ability: 'destroy') || FactoryGirl.create(:ability_user_destroy)].each do |ability|
        user_role.abilities << ability
      end
    end
  end

  factory :support_role, class: Role do
    name 'support'
    after(:build) do |support_role|
      [Ability.find_by(domain: 'user', ability: 'index') || FactoryGirl.create(:ability_user_index),
       Ability.find_by(domain: 'user', ability: 'show') || FactoryGirl.create(:ability_user_show),
       Ability.find_by(domain: 'user', ability: 'create') || FactoryGirl.create(:ability_user_create),
       Ability.find_by(domain: 'user', ability: 'update') || FactoryGirl.create(:ability_user_update),
       Ability.find_by(domain: 'user', ability: 'destroy')|| FactoryGirl.create(:ability_user_destroy),
       Ability.find_by(domain: 'role', ability: 'index') || FactoryGirl.create(:ability_role_index),
       Ability.find_by(domain: 'role', ability: 'show') ||FactoryGirl.create(:ability_role_show),
       Ability.find_by(domain: 'role', ability: 'create') ||FactoryGirl.create(:ability_role_create),
       Ability.find_by(domain: 'role', ability: 'update') ||FactoryGirl.create(:ability_role_update),
       Ability.find_by(domain: 'role', ability: 'destroy')||FactoryGirl.create(:ability_role_destroy)].each do |ability|
        support_role.abilities << ability
      end
    end
  end

  factory :guest_role, class: Role do
    name 'Guest'
    # Guest no have roles
  end


end
