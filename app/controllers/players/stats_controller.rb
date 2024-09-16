module Players
  class StatsController < ApplicationController
    # @route GET /players/stats (players_stats)
    def show
      @player = if params[:friendship_id]
        current_player.friendships.find(params[:friendship_id]).player_2
      else
        current_player
      end

      @date_range = start_date..end_date
      @played_matches_count = @player.matches.where(played_at: @date_range).count
      @won_matches_count = WonMatchesCountSQL.new(player_id: @player.id, start_date: start_date, end_date: end_date).execute
    end

    private

    def start_date
      fetch_date(:from, Date.today.beginning_of_month)
    end

    def end_date
      fetch_date(:to, Date.today.end_of_month)
    end

    def fetch_date(param_name, default_date)
      if date_params[param_name].present?
        Date.parse(params[param_name])
      else
        default_date
      end
    rescue Date::Error, ArgumentError
      default_date
    end

    def date_params
      params.permit(:from, :to)
    end
  end
end
