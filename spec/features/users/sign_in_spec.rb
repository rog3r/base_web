
# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise do

  #let(:user) { build :user }
  let(:not_found_in_database_msg) { I18n.t('devise.failure.not_found_in_database')  }
  let(:user) { FactoryGirl.create(:user) }

  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'user can sign in with valid credentials' , js: true do
    #user = FactoryGirl.create(:user)
   # user.skip_confirmation!
    sign_in user
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(page).not_to have_content not_found_in_database_msg
  end

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  #scenario 'user cannot sign in if not registered' do
  scenario I18n.translate('user_cannot_sign_in_if_not_registered') do
    signin('test@example.com', 'please123')
    expect(page).to have_content not_found_in_database_msg  #'Invalid email or password.'
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    #user = FactoryGirl.create(:user)
    signin('invalid@email.com', user.password)
    expect(page).to have_content not_found_in_database_msg  #  'Invalid email or password.'
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    #user = FactoryGirl.create(:user)
    signin(user.email, 'invalidpass')
    expect(page).to have_content  I18n.translate('devise.failure.invalid')   #  'Invalid email or password.'
  end

end