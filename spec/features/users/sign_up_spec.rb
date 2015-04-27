# /users/sign_up_spec.rb
require 'spec_helper'

if Devise.mappings[:user].registerable? 

# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise do

  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address and password
  #   Then I see a successful sign up message
  scenario 'visitor can sign up with valid email address and password' do
    #sign_up_with('test_signup@example.com', 'please123', 'please123')
    sign_up build(:user)
    expect(page).to have_content I18n.translate('devise.registrations.signed_up') #'Welcome! You have signed up successfully.'
  end

  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address', js: true do
    sign_up build(:user, email: 'invalid_email')
    expect { sign_up build(:user, email: 'invalid_email') }.not_to change { User.count }
    #expect { sign_up user }.not_to change { User.count }
   # expect(page).to have_content   I18n.translate('devise.failure.invalid')  #  'Invalid email or password.'
   expect(page).to have_content I18n.t('activerecord.attributes.user.email')
   expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.email.invalid')
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    sign_up build(:user, password: '', password_confirmation: '')
    #expect { sign_up user }.not_to change { User.count }
    expect(page).to have_content I18n.t('activerecord.attributes.user.password')
    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password.blank') # "Password can't be blank"
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    sign_up build(:user, password: 'please', password_confirmation: 'please')#sign_up_with('test@example.com', 'please', 'please')
    #expect { sign_up user }.not_to change { User.count }
    expect(page).to have_content I18n.translate('activerecord.errors.models.user.attributes.password.too_short') # 'Password is too short'
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    user = build(:user, password_confirmation: '')
    expect { sign_up user }.not_to change { User.count }
    #expect(page).to have_error_message "Password confirmation doesn't match Password"
    #expect(page).to have_content I18n.translate('errors.messages.confirmation') # "Confirme sua senha não é igual a Senha"
    expect(page).to have_content I18n.t('errors.messages.confirmation', attribute: user.password_confirmation ) # "Confirme sua senha não é igual a Senha"
    #expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password_confirmation.blank')
   # expect(page).to have_content 'Confirme sua senha não é igual a Senha' # "Password confirmation doesn't match"
  #  expect(page).to have_content I18n.translate('activerecord.errors.models.user.attributes.password.confirmation') # "Password confirmation doesn't match"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do #, js: true do
    #sign_up_with('test_mismatch@example.com', 'please123', 'mismatch')
    user = build(:user, password: 'please123', password_confirmation: 'mismatch')
    expect { sign_up user }.not_to change { User.count }
    #expect(page).to have_content I18n.t('errors.messages.confirmation', attribute: User.human_attribute_name(:password).capitalize) # "Confirme sua senha não é igual a Senha"
    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password_confirmation.confirmation') # "Password confirmation doesn't match"
  end


  #scenario "already registered email" do
  #
  #  create(:user, email: "dave@example.tld")
  #
  #  fill_in "Email", with: "dave@example.tld"
  #  fill_in "Password", with: "test-password"
  #  fill_in "Password confirmation", with: "test-password"
  #  click_button "Sign up"
  #
  #  expect(page).to have_error_message "Email has already been taken"
  #end

  #page.should have_selector('alert-success', :text => "Update successfully submitted")


end


end