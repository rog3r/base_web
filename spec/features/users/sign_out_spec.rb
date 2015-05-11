
# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
feature 'Sign out', :devise do
  let(:user) { FactoryGirl.create(:user) }

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  scenario 'user signs out successfully', js: true do
    #user = FactoryGirl.create(:confirmed_user)
    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_link('', href: destroy_user_session_path)
    #expect(page).to have_content  I18n.t('logout') #'Log out'

    #click_link I18n.translate('logout')
    click_link('logout')#id do link de logout
    page.execute_script("$('body').find('a.confirm:first').trigger('click')")

    expect(page).not_to have_link('', href: destroy_user_session_path)
    #expect(page).to have_content  I18n.t('devise.sessions.signed_out') #'Signed out successfully.'
  end

end














#
#feature 'Logout', :devise do
#
#  # Scenario: User signs out successfully
#  #   Given I am signed in
#  #   When I sign out
#  #   Then I see a signed out message
#  scenario 'user signs out successfully' do
#    user = FactoryGirl.create(:user)
#    signin(user.email, user.password)
#    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
#    click_link 'Sign out'
#    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
#  end
#
#end

#scenario 'when a user is signed in' , :js => true do
#  login_as(user, :scope => :user)
#  visit root_path
#  expect(page).to have_content 'Sign out'
#  #expect(page).to have_link('Sign out', destroy_user_session_path)
#  #expect(page).not_to have_link('Sign up', new_user_registration_path)
#  #expect(page).not_to have_link('Sign in', new_user_session_path)
#end

#scenario 'when a user is signed in' , :js => true do
#  logout(:user)
#  expect(page).to have_link('Sign up', new_user_registration_path)
#  expect(page).to have_link('Sign in', new_user_session_path)
#  expect(page).not_to have_link('Sign out', destroy_user_session_path)
#end



