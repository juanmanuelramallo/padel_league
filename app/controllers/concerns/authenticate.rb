module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_player!
  end

  private

  def authenticate_player!
    return if current_player_signed_in?

    redirect_to new_players_session_path(redirect_to: request.fullpath), alert: "Inicia sesión para continuar."
  end
end
