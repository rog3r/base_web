# encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :set_locale
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def build_basic_search(collection_resource)
    @search = collection_resource.search(params[:q])
    result = @search.result.paginate(page: params[:page])
    @search.build_condition unless @search.conditions.any?
    result
  end

  def redirect_to_back_or_default(default = root_url)
    if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back
    else
      redirect_to default
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name 
  end


  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  #<%= select_tag 'locale', options_for_select(I18n.available_locales, I18n.locale.to_sym),:onchange => 'this.form.submit()' %>

  # forca os parametros de Locale na rota ex: localhost:3000/products?locale=pt
  def default_url_options(options = {})
    {locale: I18n.locale}
  end

end
