module Players
  class ConfirmationsController < ApplicationController
    skip_before_action :authenticate_player!

    # @route GET /players/confirmations/:id (players_confirmation)
    def show
      @player = Player.find_by(confirmation_token: params[:id])

      if @player
        @player.update!(confirmed_at: Time.current)
        session[:player_id] = @player.id
        ahoy.authenticate(@player)
        session[:must_change_password] = true
        redirect_to(
          params[:redirect_to].presence || root_path,
          notice: "Bienvenido!"
        )
      else
        redirect_to root_path, alert: "Token de confirmación inválido."
      end
    end
  end
end
