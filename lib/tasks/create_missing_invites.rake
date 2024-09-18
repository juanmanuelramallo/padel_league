task create_missing_invites: :environment do
  main_player = Player.find_by(email: "juanmanuelramallo@hey.com")
  prev_count = main_player.invitees.count
  Player.where(confirmed_at: nil).each do |player|
    next if main_player.invitees.include?(player)

    main_player.invitees << player
  end
  after_count = main_player.invitees.count
  puts "Added #{after_count - prev_count} invites"
end
