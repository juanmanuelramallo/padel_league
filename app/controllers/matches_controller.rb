class MatchesController < ApplicationController
  include Authenticate

  skip_before_action :authenticate_player!, only: [ :index, :show ]

  # @route GET /matches (matches)
  # @route GET / (root)
  def index
    @matches = Match.all.includes(
      :score_sets,
      :location,
      match_players_a: :player,
      match_players_b: :player,
    ).order(played_at: :desc)
  end

  # @route GET /matches/:id (match)
  def show
    @match = Match.includes(
      match_players_a: :player,
      match_players_b: :player,
    ).find(params[:id])
  end

  # @route GET /matches/new (new_match)
  def new
    @match = Match.new(default_params)
    @match.build_empty_match_players
    @match.score_sets.build([ {} ] * 5)
  end

  # @route POST /matches (matches)
  def create
    @match = Match.new(data)

    if @match.save
      redirect_to @match
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @route GET /matches/:id/edit (edit_match)
  def edit
    @match = Match.find(params[:id])
    @match.build_empty_match_players
    @match.score_sets = @match.score_sets.with_rank
    @match.score_sets.build([ {} ] * 5)
  end

  # @route PATCH /matches/:id (match)
  # @route PUT /matches/:id (match)
  def update
    @match = Match.find(params[:id])
    @match.score_sets = @match.score_sets.with_rank
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
      score_sets_attributes: [ :id, :score_1, :score_2, :_destroy ],
      match_players_a_attributes: [ :id, :player_id, :_destroy ],
      match_players_b_attributes: [ :id, :player_id, :_destroy ],
    )
  end

  def data
    data = match_params.slice(
      :played_at,
      :location_id,
      :score_sets_attributes,
      :match_players_a_attributes,
      :match_players_b_attributes
    )
    data[:score_sets_attributes].reject! { |_, v| v[:score_1].blank? && v[:score_2].blank? }
    data
  end
end
