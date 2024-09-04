module Players
  class ProfilesController < ApplicationController
    # @route GET /players/profiles/:id (players_profile)
    def show
      @player = Player.find(params[:id])
    end

    def new
      @player = Player.new
    end

    def create
      @player = Player.new(player_params)

      if @player.save
        @player.inviters_invite = Invite.new(inviter: @player)
        @player.inviters_invite.save!

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
