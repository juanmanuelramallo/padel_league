class MatchesController < ApplicationController
  include Authenticate

  skip_before_action :authenticate_player!, only: [ :index, :show ]

  # @route GET /matches (matches)
  # @route GET / (root)
  def index
    @matches = Match.all.includes(
      :score_sets,
      :location,
      team_1: [ :player_1, :player_2 ],
      team_2: [ :player_1, :player_2 ],
    ).order(created_at: :asc)
  end

  # @route GET /matches/:id (match)
  def show
    @match = Match.find(params[:id])
  end

  # @route GET /matches/new (new_match)
  def new
    @match = Match.new(default_params)
    @match.build_team_1
    @match.build_team_2
    @match.score_sets.build([ {} ] * 5)
  end

  # @route POST /matches (matches)
  def create
    @match = Match.new(data)
    team_1, team_2 = find_or_initialize_teams
    @match.team_1 = team_1
    @match.team_2 = team_2

    if @match.save
      redirect_to @match
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @route GET /matches/:id/edit (edit_match)
  def edit
    @match = Match.find(params[:id])
    @match.score_sets.build([ {} ] * 5)
  end

  # @route PATCH /matches/:id (match)
  # @route PUT /matches/:id (match)
  def update
    @match = Match.find(params[:id])
    team_1, team_2 = find_or_initialize_teams
    @match.team_1 = team_1
    @match.team_2 = team_2
    @match.assign_attributes(data)

    if @match.save
      redirect_to @match
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # @route DELETE /matches/:id (match)
  def destroy
    @match = Match.find(params[:id])
    @match.destroy!
    redirect_to matches_path, notice: "Partido eliminado"
  end

  private

  def find_or_initialize_teams
    team_1 = Team.find_or_initialize_by(
      player_1_id: match_params[:team_1_attributes][:player_1_id],
      player_2_id: match_params[:team_1_attributes][:player_2_id]
    )
    team_2 = Team.find_or_initialize_by(
      player_1_id: match_params[:team_2_attributes][:player_1_id],
      player_2_id: match_params[:team_2_attributes][:player_2_id]
    )

    [ team_1, team_2 ]
  end

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
      team_2_attributes: [ :player_1_id, :player_2_id ],
      score_sets_attributes: [ :id, :score_1, :score_2, :_destroy ]
    )
  end

  def data
    data = match_params.slice(:played_at, :location_id, :score_sets_attributes)
    data[:score_sets_attributes].reject! { |_, v| v[:score_1].blank? && v[:score_2].blank? }
    data
  end
end
