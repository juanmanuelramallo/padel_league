task :assign_position_score_sets, [] => :environment do
  ScoreSet.transaction do
    Match.find_each do |match|
      match.score_sets_a.where.not(score: nil).each_with_index do |score_set, index|
        score_set.update!(position: index)
      end

      match.score_sets_b.where.not(score: nil).each_with_index do |score_set, index|
        score_set.update!(position: index)
      end
    end
  end
  puts "Update score sets with position"
end
