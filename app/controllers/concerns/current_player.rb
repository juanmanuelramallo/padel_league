module CurrentPlayer
  extend ActiveSupport::Concern

  included do
    helper_method :current_player
    helper_method :current_player_signed_in?
  end

  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  def current_player_signed_in?
    current_player.present?
  end
end
