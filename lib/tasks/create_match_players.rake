task :create_match_players, [] => :environment do
  prev_count = MatchPlayer.count
  Match.transaction do
    Match.all.each do |match|
      match.match_players.find_or_create_by!(player_id: match.team_1.player_1_id, team_id: "a")
      match.match_players.find_or_create_by!(player_id: match.team_1.player_2_id, team_id: "a")

      match.match_players.find_or_create_by!(player_id: match.team_2.player_1_id, team_id: "b")
      match.match_players.find_or_create_by!(player_id: match.team_2.player_2_id, team_id: "b")
    end
  end
  after_count = MatchPlayer.count

  puts "Created #{after_count - prev_count} match players"
end
