
RSpec::Matchers.define :have_error_message do |m|
  match do |page|
    page.has_selector?('div.alert.alert-error', text: m)
  end
end

# This will then hopefully enable you to write tests like:
# it { should have_error_message("Invalid") }
# it { should_not have_error_message("Invalid") }