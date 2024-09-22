module Matches
  class ConfirmationsController < ApplicationController
    # @route POST /matches/:match_id/confirmations (match_match_confirmations)
    def create
      @match = current_player.matches.find(params[:match_id])
      @match_confirmation = MatchConfirmation.new(
        match: @match,
        confirmed_by: current_player,
        confirmed_at: Time.current,
      )

      if @match_confirmation.save
        redirect_to @match, notice: "Partido confirmado."
      else
        redirect_to @match, alert: "No se pudo confirmar. Reintentá más tarde."
      end
    end
  end
end
