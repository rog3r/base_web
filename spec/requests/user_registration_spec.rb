require 'spec_helper'

if Devise.mappings[:user].registerable?    
 
    describe 'user registration' do
      it 'allows new users to register with an email address and password' do
        visit '/users/sign_up'

        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[name]', with: 'User Name'
        fill_in 'user[password]', with: 'teste123456'
        fill_in 'user[password_confirmation]', with: 'teste123456'

        click_button I18n.t('devise.registrations.new.submit')#'Sign up'
        expect(page).to have_content I18n.t('devise.registrations.signed_up')#'Welcome! You have signed up successfully.'
        #page.should have_content('Welcome! You have signed up successfully.')  "DEPRECATED!!!!!"
      end
    end

 end 