module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_player!
    before_action :check_password_change
  end

  private

  def authenticate_player!
    return if current_player_signed_in?

    redirect_to new_players_session_path(redirect_to: request.fullpath), alert: "Inicia sesión para continuar."
  end

  def check_password_change
    return unless current_player_signed_in? && session[:must_change_password]

    redirect_to edit_players_profile_path, alert: "Debes crear una contraseña antes de continuar."
  end
end
