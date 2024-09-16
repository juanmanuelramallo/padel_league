task :remove_empty_score_sets, [] => :environment do
  prev_count = ScoreSet.count
  ScoreSet.where(score: nil).destroy_all
  after_count = ScoreSet.count
  puts "Removed #{prev_count - after_count} empty score sets"
end
