task create_missing_confirmation_tokens: :environment do
  prev_count = Player.where(confirmed_at: nil, confirmation_token: nil).count
  Player.where(confirmed_at: nil, confirmation_token: nil).each do |player|
    player.update(confirmation_token: SecureRandom.urlsafe_base64)
  end
  new_count = Player.where(confirmed_at: nil, confirmation_token: nil).count
  puts "Created #{prev_count - new_count} missing confirmation tokens"
end
