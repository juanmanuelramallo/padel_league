module Players
  class InviteesController < ApplicationController
    # @route GET /players/invitees (players_invitees)
    def index
      @invitees = current_player.invitees
    end

    # @route GET /players/invitees/:id (players_invitee)
    def show
      @invitee = current_player.invitees.find(params[:id])
    end

    # @route GET /players/invitees/new (new_players_invitee)
    def new
      @player = Player.new
    end

    # @route GET /players/invitees/:id/edit (edit_players_invitee)
    def edit
      @player = current_player.invitees.find(params[:id])
    end

    # @route POST /players/invitees (players_invitees)
    def create
      @player = Player.new(player_params)

      if @player.save
        Invite.create!(inviter: current_player, invitee: @player)

        redirect_to players_invitee_path(@player), status: :see_other
      else
        render :new, status: :unprocessable_entity
      end
    end

    # @route PATCH /players/invitees/:id (players_invitee)
    # @route PUT /players/invitees/:id (players_invitee)
    def update
      @player = current_player.invitees.find(params[:id])

      if @player.confirmed_at.blank? && @player.update(player_params)
        redirect_to players_invitee_path(@player), status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # @route DELETE /players/invitees/:id (players_invitee)
    def destroy
      @player = current_player.invitees.find(params[:id])
      if @player.confirmed_at.blank?
        @player.destroy

        redirect_to players_invitees_path, notice: "Jugador eliminado.", status: :see_other
      else
        redirect_to players_invitee_path(@player), alert: "Jugador ya confirmado, no se eliminó.", status: :see_other
      end
    end

    private

    def player_params
      params.require(:player).permit(:name, :email, :phone)
    end
  end
end
