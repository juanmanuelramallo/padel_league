module Players
  class InviteesController < ApplicationController
    # @route GET /players/invitees (players_invitees)
    def index
      @invitees = current_player.invitees
    end

    # @route GET /players/invitees/:id (players_invitee)
    def show
      @invitee = current_player.invitees.find(params[:id])

      if @invitee.confirmed_at.blank?
        @qr = RQRCode::QRCode.new(players_confirmation_url(@invitee.confirmation_token), size: 10)
          .as_svg(
            color: "000",
            shape_rendering: "crispEdges",
            module_size: 6,
            standalone: true,
            use_path: true
          )
      end
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
      @player = Player.new(player_params.merge(confirmation_token:))

      if @player.save
        Invite.create!(inviter: current_player, invitee: @player)
        PlayerMailer.with(
          inviter: current_player,
          invitee: @player
        ).invite.deliver_later

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

    def confirmation_token
      SecureRandom.urlsafe_base64
    end
  end
end
