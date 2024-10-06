module Players
  class FriendTokensController < ApplicationController
    # @route GET /players/friend_token (players_friend_token)
    def show
      @qr_url = add_players_friend_token_url(friend_token: current_player.friend_token)
      @qr = RQRCode::QRCode.new(@qr_url, size: 10, level: :m)
        .as_svg(
          color: "000",
          shape_rendering: "crispEdges",
          module_size: 11,
          standalone: true,
          use_path: true,
          viewbox: true
        )
    end

    # Add a friend by friend token
    # @route GET /players/friend_token/add (add_players_friend_token)
    def add
      player = Player.find_by(friend_token: friend_token_params[:friend_token])


      if player
        if current_player.friends.exists?(id: player.id)
          redirect_to players_friendships_path, alert: "Ya eres amigo de #{player.name}"
          return
        end

        current_player.friends << player
        player.friends << current_player
        redirect_to players_friendships_path, notice: "Agregaste a #{player.name} como amigo"
      else
        redirect_to players_friendships_path, alert: "No se encontró a ningún jugador"
      end
    end

    private

    def friend_token_params
      params.permit(:friend_token)
    end
  end
end
