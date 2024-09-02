class MatchesController < ApplicationController
  include Authenticate

  # @route GET /matches (matches)
  # @route GET / (root)
  def index
    @matches = Match.all
  end
end
