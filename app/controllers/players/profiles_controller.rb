module Players
  class ProfilesController < ApplicationController
    # @route GET /players/profiles/:id (players_profile)
    def show
      @player = Player.find(params[:id])
    end

    # @route GET /players/profiles/new (new_players_profile)
    def new
      @player = Player.new
    end

    # @route POST /players/profiles (players_profiles)
    def create
      @player = Player.new(player_params)

      if @player.save
        redirect_to players_profile_path(@player)
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def player_params
      params.require(:player).permit(:name, :email, :phone)
    end
  end
end
