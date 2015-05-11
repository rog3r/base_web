require 'spec_helper'

describe User do
  let(:user) { build(:user, email: nil) }

  describe 'relationship' do #'association'
    it { expect(user).to have_many(:role_users) }
    it { expect(user).to have_many(:roles).through(:role_users) }
    it { expect(user).to have_many(:abilities).through(:roles) }
  end

  describe 'validations' do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }
  end


  it 'has a valid factory' do
    expect(build(:user)).to be_valid #build(:user).should be_valid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it 'is valid with name, email and password confirmation' do
    u = create(:user)
    expect(u).to be_valid
  end

  it 'is invalid without email' do
    u = build(:user, email: nil)
    expect(u).to have(1).error_on(:email) # have(1).errors_on(:email)
  end

  it 'is invalid without name' do
    u = build(:user, name: nil)
    expect(u).to have(1).error_on(:name)
  end

  it "is invalid if passwords don't match" do
    u = FactoryGirl.build(:user, password: 'pw177777', password_confirmation: 'wp199999')
    expect(u).to have(1).error_on(:password_confirmation)
  end


  # it 'is invalid if no activation code is generated' do
  #   u = create(:user)
  #   expect(u.activation_code).to_not be_nil
  # end

  # it 'sends a confirmation email after sign up' do
  #   u = create(:user)
  #   open_last_email.should be_delivered_to u.email
  # end
  #

  # it 'shoud have assigned roles' do
  #   saved_users = [FactoryGirl.find_or_create(:user_bart), FactoryGirl.find_or_create(:user_lisa)]
  #   assigns(:users).should eq(saved_users)
  # end


end
