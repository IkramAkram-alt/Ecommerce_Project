class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized



  protected

  def configure_permitted_parameters
    attributes = [:roles,:firstName,:lastName,:user_role,:avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end