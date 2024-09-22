class ApplicationController < ActionController::Base
  include Authenticate
  include CurrentPlayer
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern if Rails.env.production?
end
