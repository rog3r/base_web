module Features
  module DeviseSessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: confirmation
      click_button I18n.t('devise.registrations.new.submit') #'Sign up' #click_button I18n.t('devise.sessions.new.submit')
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      click_button I18n.t('devise.sessions.new.submit') # 'Sign in'
    end

    def sign_in(user)
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button I18n.t('devise.sessions.new.submit') # 'Sign in'
    end

    #def sign_in(user, scope = :user)
    #  login_as(user, scope: scope)
    #end

    def sign_out(scope = :user)
      logout(scope)
    end

    def sign_up(user)
      visit new_user_registration_path #'/users/sign_up' #new_user_registration_path
      fill_in I18n.t('activerecord.attributes.user.name'), with: user.name
      fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
      fill_in I18n.t('activerecord.attributes.user.password'), with: user.password
      fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: user.password_confirmation
      click_button I18n.t('devise.registrations.new.submit')
    end

  end
end