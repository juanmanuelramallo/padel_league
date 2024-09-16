task create_friendships: :environment do
  prev_count = Friendship.count
  main_player = Player.find(1)
  other_players = Player.where.not(id: main_player.id)

  other_players.each do |player|
    Friendship.create(player_1: main_player, player_2: player, accepted_at: Time.current)
    Friendship.create(player_1: player, player_2: main_player, accepted_at: Time.current)
  end

  after_count = Friendship.count
  puts "Created #{after_count - prev_count} friendships"
end
