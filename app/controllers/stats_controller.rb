class StatsController < ApplicationController
  include Stats

  # @route GET /players/:player_id/stats (player_stats)
  def show
    @date_range = start_date..end_date
    @played_matches_count = player.matches.where(played_at: @date_range).count
    @won_matches_count = WonMatchesCountSQL.new(player_id: player.id, start_date: start_date, end_date: end_date).execute
  end
end
