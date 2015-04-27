module Selectors
  Capybara.add_selector(:href) do
    xpath {|href| ".//a[@href='#{href}']"}
  end
  # Usage:
  # find(:href, user_path(other_user)).click
  # find(:href, user_path(other_user), match: :first).click


  Capybara.add_selector(:delete_link) do
    xpath {|delete_link| ".//a[@href='#{delete_link}' and @data-method='delete']"}
  end
  # Usage:
  # find(:delete_link, user_path(other_user)).click

end



#find(:xpath, "//a[@href='#{delete_link}' and @data-method='delete']")

#module Selectors
#  # find(:href, 'google.com')
#  Capybara.add_selector(:href) do
#    xpath {|href| XPath.descendant[XPath.attr(:href).contains(href)] }
#  end
#end

# Then in the tests I use
# find(:href, some_path).click