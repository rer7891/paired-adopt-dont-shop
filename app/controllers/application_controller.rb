class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :favorite

  def favorite
    cookies[:favorites] ||= " "
  end
end
