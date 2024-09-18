class WonMatchesCountSQL < ApplicationSQL
  attr_accessor :player_id, :start_date, :end_date

  def execute
    super.first["result"].to_i
  end

  def sql
    <<~SQL.squish
        select
          count(*) as result
        from
          match_players
        join
          matches on match_players.match_id = matches.id
        where
          matches.played_at between $1 and $2
          and match_players.player_id = $3
          and matches.winner_team_id = match_players.team_id
    SQL
  end

  def bind_values
    [
      start_date,
      end_date,
      player_id
    ]
  end
end
