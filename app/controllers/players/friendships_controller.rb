module Players
  class FriendshipsController < ApplicationController
    # @route GET /players/friendships (players_friendships)
    def index
      @friendships = current_player
        .friendships
        .includes(:player_2)
        .order("players.name")
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
            module_size: 11,
            standalone: true,
            use_path: true,
            viewbox: true
          )
      end
    end
  end
end
