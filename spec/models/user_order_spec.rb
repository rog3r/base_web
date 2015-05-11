require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'orders by email desc' do
    User.delete_all
    rogerio = FactoryGirl.create(:user, email: 'rogerio@email.com')
    admin = FactoryGirl.create(:user, email: 'admin@email.com')

    expect(User.order("email DESC").map(&:email)).to eq(['rogerio@email.com', 'admin@email.com'])
  end
end