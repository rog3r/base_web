def confirm_dialog
  page.driver.browser.switch_to.alert.accept
end

def switch_to_popup
  popup = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(popup)
end

def assert_no_js_errors
  errors = page.driver.error_messages
  assert_equal 0, errors.size, errors.ai
end

def assert_no_alerts(types = [:alert, :confirm, :prompt])
  types.each do |type|
    alerts = page.driver.send(:"#{type}_messages")
    assert_equal 0, alerts.size, alerts.ai
  end
end


#Use:  wait_for_element_present(element, 1, 120, 10)
def wait_for_element_present(element, element_count = 1, max_wait_time = 60, sleep_time = 10)
  if element
    cnt = max_wait_time / sleep_time
    cnt.times do |c|
      if page.all(element).count < element_count
        visit current_url
        sleep sleep_time
        puts "Try reload and sleep"
      end
    end
  else
    puts "Element not selected."
  end
end



# assuming you have already created an instance of a Selenium WebDriver

#def driver.scroll_by_selector(selector)
#  self.execute_script("window.scrollBy(0,document.querySelector('#{selector}').getBoundingClientRect().top);")
#end

# Usage:
# driver.scroll_by_selector("#my_lower_on_the_page_div")
# element = driver.find_element(:id, "my_lower_on_the_page_div")
# element.click





# to enable to click Facebook login button we must switch to Facebook iframe
# facebok_iframe_name = find(:xpath, "//*[@id='fb-button-explore']/span/iframe")[:name]
# page.driver.browser.switch_to.frame facebok_iframe_name

# now we can click the Facebook login button which open the pop-up
# find(:id, "u_0_1").click()

# to enable to fill the Facebook creditional set popup windows and then switch to popup window
# popup = page.driver.browser.window_handles.last
# page.driver.browser.switch_to.window(popup)

# fill form and click login button
# fill_in("email", :with => "mesut@testrisk.com")
# fill_in("pass", :with => "Password123")
# find(:id, "u_0_1").click()

# don't forget to switch to main window
# page.driver.browser.switch_to.window(main)