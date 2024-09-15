module Players
  class FriendshipsController < ApplicationController
    # @route GET /players/friendships (players_friendships)
    def index
      @friendships = current_player
        .friendships
        .includes(:player_2)
        .order("players.name")
      @pending_friendships = current_player
        .pending_friendships
        .includes(:player_2)
        .order("players.name")
      @requested_friendships = Friendship
        .where(player_2: current_player, accepted_at: nil)
        .includes(:player_1)
        .order("players.name")
    end

    # Request a friendship
    # @route POST /players/friendships (players_friendships)
    def create
      @friendships = [
        Friendship.new(
          player_1: current_player,
          player_2: Player.find(params[:player_id]),
          accepted_at: Time.zone.now
        ),
        Friendship.new(
          player_1: Player.find(params[:player_id]),
          player_2: current_player,
          accepted_at: nil
        )
      ]

      Friendship.transaction do
        @friendships.each(&:save!)
      end

      if @friendships.all?(&:persisted?)
        redirect_to players_friendships_path, status: :see_other, notice: "Solicitud enviada"
      else
        redirect_to players_friendships_path, status: :unprocessable_entity, alert: "No se pudo enviar la solicitud"
      end
    end

    # Accept a friend request
    # @route PATCH /players/friendships/:id (players_friendship)
    # @route PUT /players/friendships/:id (players_friendship)
    def update
      @friendship = Friendship
        .where(player_2: current_player, accepted_at: nil)
        .find(params[:id])

      if @friendship.update(accepted_at: Time.zone.now)
        redirect_to players_friendships_path, status: :see_other, notice: "Solicitud aceptada"
      else
        redirect_to players_friendships_path, status: :unprocessable_entity, alert: "No se pudo aceptar la solicitud"
      end
    end

    # @route GET /players/friendships/:id (players_friendship)
    def show
      @friendship = current_player
        .friendships
        .includes(:player_2)
        .find(params[:id])
      @friend = @friendship.player_2


      if @friend.confirmed_at.blank? && @friend.confirmation_token.present?
        @qr_url = players_confirmation_url(@friend.confirmation_token)
        @qr = RQRCode::QRCode.new(@qr_url, size: 10)
          .as_svg(
            color: "000",
            shape_rendering: "crispEdges",
            module_size: 6,
            standalone: true,
            use_path: true
          )
      end
    end
  end
end
