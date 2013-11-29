class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # remove if not multi lingual
  def default_url_options(options={})
    { locale: I18n.locale }
  end

  private
  def extract_locale_from_accept_language_header
    header = request.env['HTTP_ACCEPT_LANGUAGE']
    header.scan(/^[a-z]{2}/).first unless header.nil?
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end
  # end multi lingual

end
