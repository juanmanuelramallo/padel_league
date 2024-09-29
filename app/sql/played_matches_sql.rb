class PlayedMatchesSQL < ApplicationSQL
  attr_accessor :player_id, :start_date, :end_date, :interval

  def execute
    super.to_h { |row| [ row["date"], row["result"] ] }
  end

  def sql
    <<~SQL.squish
        select
          date_trunc($4, date)::date as date,
          count(match_players.id) as result
        from
          generate_series($1::date, $2::date, '1 day'::interval) as date
        left join
          matches on date = matches.played_at::date
        left join
          match_players on match_players.match_id = matches.id
            and match_players.player_id = $3
        group by
          1
        order by
          1
    SQL
  end

  def bind_values
    [
      start_date,
      end_date,
      player_id,
      interval
    ]
  end
end
