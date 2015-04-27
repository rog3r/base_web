# Feature: Edit User
#   As a user
#   I want to edit my profile
#   So I can visit protected areas of the site
feature 'Edit User', :devise do

  #let(:user) { FactoryGirl.create(:user) }
  let(:submit_btn) { I18n.t('devise.registrations.edit.submit') }
  let(:updated_msg) { I18n.t('devise.registrations.updated') }

  #before(:each) do
  #sign_in(user)
  #visit edit_user_registration_path
  #end



  ## Scenario: User cannot edit another user's profile
  ##   Given I am signed in
  ##   When I try to edit another user's profile
  ##   Then I see my own 'edit profile' page
  #scenario "user cannot cannot edit another user's profile", :me do
  #  me = FactoryGirl.create(:user)
  #  other = FactoryGirl.create(:user, email: 'other@example.com')
  #  login_as(me, scope: :user)
  #  visit edit_user_registration_path(other)
  #  expect(page).to have_content 'Edit User'
  #  expect(page).to have_field('Email', with: me.email)
  #end



if Devise.mappings[:user].registerable? 
  # Scenario: User changes password
  #   Given I am signed in
  #   When I change my password
  #   Then I see an account updated message
  scenario 'user can changes the password' , js: true do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'user[current_password]', with: user.password
    fill_in 'user[password]',  with: 'mynewpassword'
    fill_in 'user[password_confirmation]',  with: 'mynewpassword'
    click_button submit_btn
    expect(page).to have_content(updated_msg)
  end
end #if Devise.mappings[:user].registerable? 





  #scenario 'User changes the username' , js: true do
  #  fill_in 'user[name]', with: 'New Name Updated'
  #  fill_in 'user[password]', with: user.password
  #  click_button submit_btn
  #  expect(page).to have_content I18n.t('devise.registrations.updated')
  #end

  #fill_in I18n.t('activerecord.attributes.user.current_password'), with: user.password
  #fill_in I18n.t('activerecord.attributes.user.password'), with: 'mynewpassword'
  #fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'mynewpassword'
  #txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
  #expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)

  #describe 'Edit User' do
  #  before(:each) do
  #    @user = FactoryGirl.create(:user) #@user = create(:user)
  #    sign_in(@user)
  #    visit edit_user_registration_path
  #  end
  #
  #  it 'User changes the password' do
  #    #fill_in 'user[password]', with: 'mynewpassword'
  #    #fill_in 'user[password_confirmation]', with: 'mynewpassword'
  #    #fill_in 'user[current_password]', with: @user.password
  #    fill_in I18n.t('activerecord.attributes.user.password'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.current_password'), with: @user.password
  #    click_button I18n.t('devise.registrations.edit.submit')
  #    expect(page).to have_content I18n.t('devise.registrations.updated')
  #  end
  #
  #  it 'User changes the username' do
  #    fill_in I18n.t('activerecord.attributes.user.password'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.current_password'), with: @user.password
  #    click_button I18n.t('devise.registrations.edit.submit')
  #    expect(page).to have_content I18n.t('devise.registrations.updated')
  #  end
  #
  #  it 'User enters wrong existing password' do
  #    fill_in I18n.t('activerecord.attributes.user.password'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.current_password'), with: 'wrongpassword'
  #    click_button I18n.t('devise.registrations.edit.submit')
  #    expect(page).to have_content I18n.t('activerecord.attributes.user.current_password')
  #    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.current_password.invalid')
  #  end
  #
  #
  #  it 'User enters mismatched password and confirmation' do
  #    fill_in I18n.t('activerecord.attributes.user.password'), with: 'mynewpassword'
  #    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'mismatchedpassword'
  #    fill_in I18n.t('activerecord.attributes.user.current_password'), with: @user.password
  #    click_button I18n.t('devise.registrations.edit.submit')
  #    expect(page).to have_content I18n.t('activerecord.attributes.user.password')
  #    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password.confirmation')
  #  end
  #
  #
  #  it "User enters too short password" do
  #    fill_in I18n.t('activerecord.attributes.user.password'), with: '123'
  #    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: '123'
  #    fill_in I18n.t('activerecord.attributes.user.current_password'), with: @user.password
  #    click_button I18n.t('devise.registrations.edit.submit')
  #    expect(page).to have_content I18n.t('activerecord.attributes.user.password')
  #    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password.too_short')
  #  end
  #
  #
  #end
end

