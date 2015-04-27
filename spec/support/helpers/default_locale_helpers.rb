# workaround, to set default locale for ALL spec

class ActionView::TestCase::TestController
  def default_url_options(options={})
    { :locale => I18n.default_locale }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { :locale => I18n.default_locale }
  end
end


# https://github.com/rspec/rspec-rails/issues/255
#config.before(:each, type: :feature) do
#  default_url_options[:locale] = I18n.default_locale
#end