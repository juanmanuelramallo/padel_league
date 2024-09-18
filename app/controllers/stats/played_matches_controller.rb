module Stats
  class PlayedMatchesController < ApplicationController
    include Stats

    # @route GET /players/:player_id/stats/played_matches (player_stats_played_matches)
    def show
      render json: PlayedMatchesSQL.new(
        player_id: player.id,
        start_date:,
        end_date:,
        interval: "week"
      ).execute
    end
  end
end
