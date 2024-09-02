module Players
  class SessionsController < ApplicationController
    skip_before_action :authenticate_player!, only: %i[new create]

    # @route GET /players/session/new (new_players_session)
    def new
      if current_player_signed_in?
        redirect_to root_path, notice: "Ya iniciaste sesión"
        return
      end

      @player = Player.new
      # ahoy.track "Viewed login"
    end

    # @route POST /players/session (players_session)
    def create
      @player = Player.find_by(email: player_params[:email])

      if @player&.authenticate(player_params[:password])
        session[:player_id] = @player.id
        # ahoy.authenticate(@player)
        # ahoy.track "Logged in"

        redirect_to(
          params[:redirect_to].presence || root_path,
          notice: "Adentro!"
        )
      else
        @player = Player.new(email: player_params[:email])
        flash.now[:alert] = "Hmmm email o contraseña incorrectos"
        render :new, status: :unauthorized
      end
    end

    # @route DELETE /players/session (players_session)
    def destroy
      session[:player_id] = nil
      # ahoy.track "Logged out"
      redirect_to new_players_session_path, notice: "Cerraste sesión"
    end

    private

    def player_params
      params.require(:player).permit(:email, :password)
    end
  end
end
