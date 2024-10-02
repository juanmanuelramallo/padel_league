class ApplicationController < ActionController::Base
  include Authenticate
  include CurrentPlayer
  include Tracking
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern if Rails.env.production?

  def require_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.admin_username &&
        password == Rails.application.credentials.admin_password
    end
  end
end
