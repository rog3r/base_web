#require 'spec_helper'
#include Warden::Test::Helpers
#Warden.test_mode!

# Feature: User Search
#   As a admin
#   I want to search a user
#   So I can visit users list and search a user
feature 'admin searching for a specific user' do

  context 'when logged in as admin' do
    #let(:search_field) {page.find('[@id=search_field]')}#{ page.find_by_id('search_field') } #page.find('[@id=create-account-link]')
    let(:search_btn) { I18n.t('search') } #'Search'

    before(:each) do
      admin = FactoryGirl.create(:user, :with_admin_role)# FactoryGirl.create(:admin_user)
      login_as(admin, scope: :user)
      user1 = FactoryGirl.create(:user, email: 'user_one@email.com')
      user2 = FactoryGirl.create(:user, email: 'user_two@email.com')
    end

    # Scenario: Admin search user by email <like>
    #   Given I am signed in
    #   When I put a user email in the search field
    #   And I click on a search button
    #   Then I see a user in a result table
    scenario 'admin searches for a specific user by email like', js: true do
      visit users_path # manage_users_path
      expect(page).to have_content 'user_one@email.com'
      expect(page).to have_content 'user_two@email.com'
      #page.body.should have_content 'user_one@email.com'
      #page.body.should have_content 'user_two@email.com'
      #fill_in page.find_by_id('search_field'), with: 'user_one'
      select(User.human_attribute_name(:email), from: 'field')
      fill_in 'search_field', with: 'user_one'
      click_button search_btn
      sleep(2)
      expect(page).to have_content 'user_one@email.com'
     # expect(page).not_to have_content 'user_two@email.com'
      #page.body.should have_content 'user_one@email.com'
      #page.body.should_not have_content 'user_two@email.com'
    end


    #describe "Search courses" do
    #  it "by topic" do
    #    240.times { Course.create! }
    #    Course.create!(topic: "biology", name: "A001")
    #    Course.create!(topic: "biology", name: "B205")
    #    visit search_path
    #    fill_in "Search", with: "biology"
    #    click_button "Search"
    #    page.should have_content "A001"
    #    page.should have_content "B205"
    #  end
    #end

  end
end


#Scenario : Subscribing to a thread
#  Given I 've commented in a thread
#  When someone else makes a comment
#  Then I should receive an email
#  And it should have a link to that thread
#
#Scenario: Unsubscribing from a thread
#  Given I' ve subscribed to a thread
#  And I 'm on the page for that thread
#  When I click the unsubscribe link
#  And someone makes a comment
#  Then I should not receive an email
#
#Scenario: Subscribing to a forum
#  Given I' m on the index page for a forum
#  When I click the subscription link
#  And someone makes a new thread in that forum
#  Then I should receive an email
#  And it should have a link to that forum
#
#Scenario : Unsubscribing from a forum
#  Given I 've subscribed to a forum
#  And I' m on the index page for that forum
#  When I click the unsubscribe link
#  And someone makes a new thread in that forum
#  Then I should not receive an email