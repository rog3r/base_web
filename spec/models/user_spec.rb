require 'spec_helper'

describe User do
  it 'has a valid factory' do
    #build(:user).should be_valid
    expect(build(:user)).to  be_valid
  end
  it 'is invalid without an email' do
    expect( build(:user, email: nil)).to_not  be_valid
   # build(:user, email: nil).should_not be_valid
  end
end

#
#describe User do
#  it { should validate_presence_of(:email) }
#  it { should validate_uniqueness_of(:email) }
#end