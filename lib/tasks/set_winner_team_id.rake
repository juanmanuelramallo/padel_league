task :set_winner_team_id, [] => :environment do
  Match.transaction do
    Match.find_each do |match|
      if match.team_1_won?
        match.update!(winner_team_id: "a")
      elsif match.team_2_won?
        match.update!(winner_team_id: "b")
      end
    end
  end

  puts "Update winner team id"
end
