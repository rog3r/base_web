require 'spec_helper'
require 'rails_helper'

describe 'user sign in' , :js => true do
  it 'allows users to sign in after they have registered' do
    #sign_up_with('test@example.com', 'please123', 'please123')
    user = FactoryGirl.create(:user)
    user.save!
    visit '/users/sign_in' #new_user_session_path
    #User.create!(email:'rogerio@example.com', password: 'abc123456')#, password_confirmation:'abc123456')# ,confirmed_at: Time.now)
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    #fill_in 'Email',    with: 'rogerio@example.com'
    #fill_in 'Password', with: 'abc123456'

    click_button I18n.t('devise.sessions.new.submit') # 'Sign in'
    expect(page).to have_content I18n.t('devise.sessions.signed_in')#'Signed in successfully.'
    #expect(page).to have_content 'Signed in successfully.'
    #Signed out successfully.
    #assert_equal 200, @response.status
   # page.should have_content('Signed in successfully.')
  end
end


