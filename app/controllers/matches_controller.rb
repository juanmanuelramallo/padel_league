class MatchesController < ApplicationController
  include Authenticate

  # @route GET /matches (matches)
  # @route GET / (root)
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new(default_params)
  end

  def create
    @match = Match.new(match_params.slice(:played_at, :location_id))
    team_1 = Team.find_or_initialize_by(
      player_1_id: match_params[:team_1_attributes][:player_1_id],
      player_2_id: match_params[:team_1_attributes][:player_2_id]
    )
    team_2 = Team.find_or_initialize_by(
      player_1_id: match_params[:team_2_attributes][:player_1_id],
      player_2_id: match_params[:team_2_attributes][:player_2_id]
    )

    @match.team_1 = team_1
    @match.team_2 = team_2

    if @match.save
      redirect_to matches_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def default_params
    {
      played_at: Time.current,
      location_id: Location.first.id
    }
  end

  def match_params
    params.require(:match).permit(
      :played_at,
      :location_id,
      team_1_attributes: [ :player_1_id, :player_2_id ],
      team_2_attributes: [ :player_1_id, :player_2_id ]
    )
  end
end
