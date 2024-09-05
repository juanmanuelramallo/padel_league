module Players
  class ProfilesController < ApplicationController
    # @route GET /players/profile (players_profile)
    def show
      @player = current_player
    end

    # @route GET /players/profile/edit (edit_players_profile)
    def edit
      @player = current_player
    end

    # @route PATCH /players/profile (players_profile)
    # @route PUT /players/profile (players_profile)
    def update
      @player = current_player

      if @player.update(player_params)
        redirect_to players_profile_path, status: :see_other, notice: "Hecho!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def player_params
      params.require(:player).permit(:password, :password_confirmation)
    end
  end
end
