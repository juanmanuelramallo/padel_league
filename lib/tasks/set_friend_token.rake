task set_friend_token: :environment do
  prev_count = Player.where(friend_token: nil).count
  Player.where(friend_token: nil).each do |player|
    player.update(friend_token: SecureRandom.alphanumeric(64))
  end
  new_count = Player.where(friend_token: nil).count
  puts "Updated #{prev_count - new_count} players"
end
