FactoryGirl.define do


  factory :ability_admin_admin, class: Ability do
    domain 'admin'
    ability 'admin'
  end

  factory :ability_user_index, class: Ability do
    domain 'user'
    ability 'index'
  end
  factory :ability_user_show, class: Ability do
    domain 'user'
    ability 'show'
  end
  factory :ability_user_create, class: Ability do
    domain 'user'
    ability 'create'
    end
  factory :ability_user_update, class: Ability do
    domain 'user'
    ability 'update'
    end
  factory :ability_user_destroy, class: Ability do
    domain 'user'
    ability 'destroy'
  end


  factory :ability_role_index, class: Ability do
    domain 'role'
    ability 'index'
  end
  factory :ability_role_show, class: Ability do
    domain 'role'
    ability 'show'
  end
  factory :ability_role_create, class: Ability do
    domain 'role'
    ability 'create'
  end
  factory :ability_role_update, class: Ability do
    domain 'role'
    ability 'update'
  end
  factory :ability_role_destroy, class: Ability do
    domain 'role'
    ability 'destroy'
  end

end




# # ability
# let(:user_index)   { FactoryGirl.create(:user_index) }
# let(:user_show)    { FactoryGirl.create(:user_show) }
# let(:user_create)  { FactoryGirl.create(:user_create) }
# let(:user_udpate)  { FactoryGirl.create(:user_udpate) }
# let(:user_destroy) { FactoryGirl.create(:user_destroy) }


# class User < ActiveRecord::Base
#   has_many :features
#   has_many :roles, :through => :features
# end
#
#
# class Role < ActiveRecord::Base
#   has_many :features
#   has_many :users, :through => :features
# end
#
#
#
# class UserRole < ActiveRecord::Base
#   belongs_to :role
#   belongs_to :user
# end
#
#
# # revised factories
# # created the associations from the join table only
# Factory.define(:user) do |user|
#   user.name     "FooFighters"
# end
#
# Factory.define(:role) do |role|
#   role.name "FooTime"
#   role.genre "FooRock"
#   role.description "A good time"
# end
#
# # join table factory - :feature
# Factory.define(:feature) do |feature|
#   feature.association :user
#   feature.association :role
# end
