task :create_score_sets, [] => :environment do
  prev_count = ScoreSet.count
  ScoreSet.transaction do
    ScoreSet.where(team_id: nil).find_each do |score_set|
      ScoreSet.create!(
        match_id: score_set.match_id,
        score: score_set.score_1,
        team_id: "a"
      )
      ScoreSet.create!(
        match_id: score_set.match_id,
        score: score_set.score_2,
        team_id: "b"
      )
      score_set.update!(team_id: "a")
    end
  end

  after_count = ScoreSet.count
  puts "Created #{after_count - prev_count} new score sets"
end
