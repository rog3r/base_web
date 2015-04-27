# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise do

   #.model_name.human, default: "Edit #{resource_name.to_s.humanize
  let(:deleted_msg) { I18n.t('flash.actions.destroy.notice', resource_name: User.model_name.human) } # { 'Usuario removido com sucesso' } #

  before :each do
  #  User.delete_all
  end

  ## Scenario: User can't delete own account
  ##   Given I am signed in
  ##   When I delete my account
  ##   Then I should see an account deleted message
  scenario "user can't delete own account", :js do
    User.delete_all
    10.times { FactoryGirl.create(:user) }
    other_user = FactoryGirl.create(:confirmed_user)
    me = FactoryGirl.create(:admin_user)
    sign_in(me)
    visit users_path
    expect(page).to have_selector(:delete_link, user_path(other_user))
  end

  # Scenario: Admin User can delete other account
  #   Given I am signed in as admin
  #   When I delete other account
  #   Then I should see an account deleted message
  scenario 'user can delete other account', :js do
    User.delete_all
    10.times { FactoryGirl.create(:user) }
    other_user = FactoryGirl.create(:confirmed_user)
    me = FactoryGirl.create(:admin_user)
    sign_in(me)
    visit users_path
    find(:delete_link, user_path(other_user)).click
    page.execute_script("$('body').find('a.confirm:first').trigger('click')")
    sleep(0.5)
    expect(page).to have_content deleted_msg
  end



































  # TODO ajudar esse Fela http://stackoverflow.com/questions/27481289/poltergeistunable-to-click-on-bootstap-modal-dialog-ok-button
  # http://stackoverflow.com/questions/26374223/close-modal-with-capybara


  #expect { click_link('delete') }.to change(User, :count).by(-1)

  #expect(page.body).to have_selector('h1', text: heading)
  #Capybara.string(page.body).has_selector?('title', text: full_title(page_title), visible: false)

  #page.should have_selector('alert-success', :text => "Update successfully submitted")
  # page.find('.modal').find('.modal-footer').find('.btn.proceed.btn-primary').trigg‌​er('click')
  #expect(page).to have_link(' ', href: user_path(other_user), method: 'delete')
  #expect(page).to have_link('', href: user_path(other_user), 'data-method' => 'delete')
  #expect(page).to have_selector("a[href='#{user_path(other_user)}']", text: I18n.t('delete'))
  #expect(page).to have_selector("a href='#{user_path(other_user)}'")
  #expect(page).to have_selector("a[href='#{user_path(other_user)}' data-method='delete']")
  #expect(page).to have_selector("a[@href='#{user_path(other_user)}' and @data-method='delete']")    #"//a[@href='#{delete_link}' and @data-method='delete']"
  #expect(page).to have_selector("a[@href='#{user_path(other_user)}' and @data-method='delete']")    #"//a[@href='#{delete_link}' and @data-method='delete']"
  #expect(page).not_to  have_selector('a', {href: user_path(me), title: I18n.t('delete')} )#have_link('', {href: user_path(me), text: I18n.t('delete') })
  #expect(page).to have_link('', {href: user_path(other_user), text: I18n.t('delete') })
  #expect(page).not_to have_link('', {href: user_path(me), text: I18n.t('delete') })
  #expect(page).to have_link('', {href: user_path(other_user), text: I18n.t('delete') })


  #find("#photos",:visible=>false).click
  #find("#photos",:visible=>false).click
  #find(:href, "#{user_path(other_user)}?locale=pt-BR").click
  # find(:href, user_path(other_user), match: :first).click
  #find(:href, user_path(other_user)).click
  # find(:xpath, "//a[@href='#{user_path(other_user)}' and @data-method='delete']").click
  #find(:href, user_path(other_user)).click_link t('delete')

  #page.execute_script('$(document.elementFromPoint(50, 350)).click();')
  #expect(current_path).to eq playlists_path
  #expect(page).to have_css '.alert',          text: 'Signed in successfully.'
  #expect(page).to have_link 'Sign out',       href: destroy_user_session_path
  #expect(page).to have_link 'Edit profile',   href: edit_user_registration_path
  #page.driver.browser.switch_to.alert.accept
  ## or
  #page.driver.browser.switch_to.alert.dismiss
  ## or
  #page.driver.browser.switch_to.alert.text

  #page.driver.browser.accept_js_confirms
  #page.driver.browser.reject_js_confirms

  #page.driver.accept_js_confirms!
  #page.driver.accept_js_confirms!
  #within '#confirmationDialog' do
  #click_button('Ok')
  #  click_link_or_button('Ok')
  #
  #


  #page.driver.browser.switch_to.alert


  #Better yet, save a few function calls by using:
  #$("$foo a.specialLink:first");


  #within  '#confirmationDialog' do
  #  click_link('Ok')
  #end


  #
  #page.evaluate_script('window.confirm = function() { return true; }')
  #sleep(2)
  #click_link('Ok')
  #
  #sleep(0.5)
  #
  #
  ## remove fade
  #page.evaluate_script('$(".fade").removeClass("fade")')
  #within '#confirmationDialog' do
  # click_link('Ok')
  # end

  # ボタンをクリックするとモーダルが表示されるので、先に進むことができる
  #    within '#credit-card__info' do
  #      find_button('カード情報を編集する').click
  #    end
  #    within '#confirmationDialog' do
  #    #click_button('Ok')
  #    #  click_link_or_button('Ok')
  #    sleep(2.seconds)
  #    #switch_to_popup
  #    confirm_dialog
  #    click_link('Ok')
  #    sleep(2.seconds)
  # end
  #page.accept_alert
  #dismiss_modal(:confirm, :prompt)
  #page.driver.dismiss_modal(:confirm)

  #expect { click_link('delete') }.to change(User, :count).by(-1)


  ## Scenario: Admin User can delete other account
  ##   Given I am signed in as admin
  ##   When I delete other account
  ##   Then I should see an account deleted message
  #scenario 'user can delete other account' do
  #
  #  me = FactoryGirl.create(:admin_user)
  #  5.times { FactoryGirl.create(:user) }
  #  other_user = FactoryGirl.create(:user)
  #  login_as(me, scope: :user)
  #  visit users_path
  #  click_link delete_btn
  #  expect(page).to have_content deleted_msg
  #
  #
  #  describe "delete links" do
  #    it { should_not have_link("delete") }
  #    describe "as an admin user" do
  #      let(:admin) { FactoryGirl.create(:admin) }
  #      before do
  #        sign_in admin
  #        visit users_path
  #      end
  #      it { should have_link("delete", href: user_path(User.first)) }
  #      it "should be able to delete another user" do
  #        expect do
  #          click_link('delete', match: :first)
  #        end.to change(User, :count).by(-1)
  #      end
  #      it { should_not have_link('delete', href: user_path(admin)) }
  #    end
  #  end
  #end


  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  #scenario "user can delete own account" do
  #  skip 'skip a slow test'
  #  user = FactoryGirl.create(:user)
  #  login_as(user, scope: :user)
  #  visit edit_user_registration_path(user)
  #  click_button 'Cancel my account'
  #  page.driver.browser.switch_to.alert.accept
  #  expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  #end

  # Scenario: User can't delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  #scenario "user can't delete own account", :js do
  #  #skip 'skip a slow test'
  #  user = FactoryGirl.create(:user)
  #  login_as(user, scope: :user)
  #  visit edit_user_registration_path(user)
  #  click_button 'Cancel my account'
  #  page.driver.browser.switch_to.alert.accept
  #  expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  #end

end