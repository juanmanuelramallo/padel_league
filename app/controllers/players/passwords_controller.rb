module Players
  class PasswordsController < ApplicationController
    skip_before_action :authenticate_player!, only: %i[new create edit update]

    # @route GET /players/passwords/new (new_players_password)
    def new
      @player = Player.new
    end

    # @route POST /players/passwords (players_passwords)
    def create
      @player = Player.find_by(email: player_params[:email]) if player_params[:email].present?

      if @player
        @player.update(reset_password_token: SecureRandom.urlsafe_base64(32)) if @player.reset_password_token.blank?
        PlayerMailer.with(player: @player).reset_password_instructions.deliver_later
      end

      redirect_to new_players_session_path, notice: "Revisa tu correo para restablecer tu contraseña"
    end

    # @route GET /players/passwords/:id/edit (edit_players_password)
    def edit
      @player = Player.find_by(reset_password_token: params[:id])

      unless @player
        redirect_to new_players_session_path, alert: "Token inválido"
      end
    end

    # @route PATCH /players/passwords/:id (players_password)
    # @route PUT /players/passwords/:id (players_password)
    def update
      @player = Player.find_by(reset_password_token: params[:id])

      if @player && @player.update(player_params.merge(reset_password_token: nil))
        session[:player_id] = @player.id
        ahoy.authenticate(@player)

        redirect_to root_path, notice: "Contraseña restablecida"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def player_params
      params.require(:player).permit(:email, :password, :password_confirmation)
    end
  end
end
