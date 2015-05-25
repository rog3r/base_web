require 'spec_helper'

describe Role do

  # role
   let(:admin_role) { FactoryGirl.find_or_create(:admin_role) }
   let(:support_role) { FactoryGirl.find_or_create(:support_role) }
  # let(:user_role) { FactoryGirl.create(:user_role) }
  # let(:user_supporte_role) { FactoryGirl.create(:user, :with_support_roles)}



  describe 'relationship' do
    it { should have_many(:users) }
    it { should have_many(:ability_roles).dependent(:destroy) }
    it { should have_many(:abilities).through(:ability_roles) }
    it { should accept_nested_attributes_for(:ability_roles)}
    #it { should accept_nested_attributes_for(:ability_roles).update_only(true) }
  end



end
