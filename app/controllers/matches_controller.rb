class MatchesController < ApplicationController
  include Authenticate

  skip_before_action :authenticate_player!, only: [ :show ]

  # @route GET /matches (matches)
  # @route GET / (root)
  def index
    @players = current_player.friends.order(:name)
    @searched_player = @players.find_by(id: params[:player_id])

    @matches = current_player.matches.includes(
      :score_sets,
      :location,
      match_players_a: :player,
      match_players_b: :player,
    ).order(played_at: :desc)

    if @searched_player
      @matches = @matches.where(
        match_players_a: { player_id: @searched_player.id }
      ).or(
        @matches.where(match_players_b: { player_id: @searched_player.id })
      )
    end
  end

  # @route GET /matches/:id (match)
  def show
    includes = [
      :score_sets,
      match_players_a: :player,
      match_players_b: :player,
      confirmations: :confirmed_by
    ]

    if current_player
      @match = current_player.matches.includes(includes).find(params[:id])
      @can_confirm = @match.players.include?(current_player) &&
        @match.confirmations.none? { |confirmation| confirmation.confirmed_by == current_player }
    else
      @match = Match.includes(includes).find(params[:id])
      @can_confirm = false
    end
  end

  # @route GET /matches/new (new_match)
  def new
    @match = Match.new(default_params)
    @match.build_empty_match_players
    @match.build_empty_score_sets
  end

  # @route POST /matches (matches)
  def create
    @match = Match.new(data)
    @match.winner_team_id = if @match.team_1_won?
      "a"
    elsif @match.team_2_won?
      "b"
    end

    current_player_is_present = (@match.match_players_a + @match.match_players_b).any? { |mp| mp.player_id == current_player.id }

    # Ensure the current player is part of the match
    if current_player_is_present &&
        @match.save
      @match.confirmations.create!(confirmed_by: current_player, confirmed_at: Time.current)
      redirect_to @match
    else
      @match.build_empty_match_players
      @match.build_empty_score_sets

      flash.now[:alert] = "Te olvidaste de agregarte al partido" unless current_player_is_present
      render :new, status: :unprocessable_entity
    end
  end

  # @route GET /matches/:id/edit (edit_match)
  def edit
    @match = current_player.matches.find(params[:id])
    @match.build_empty_match_players
    @match.build_empty_score_sets
  end

  # @route PATCH /matches/:id (match)
  # @route PUT /matches/:id (match)
  def update
    @match = current_player.matches.find(params[:id])
    @match.assign_attributes(data)
    @match.winner_team_id = if @match.team_1_won?
      "a"
    elsif @match.team_2_won?
      "b"
    end

    if @match.save
      @match.confirmations.where.not(confirmed_by: current_player).destroy_all

      redirect_to @match
    else
      render :edit, status: :unprocessable_entity
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
      score_sets_a_attributes: [ :id, :score, :position, :_destroy ],
      score_sets_b_attributes: [ :id, :score, :position, :_destroy ],
      match_players_a_attributes: [ :id, :player_id, :_destroy ],
      match_players_b_attributes: [ :id, :player_id, :_destroy ],
    )
  end

  def data
    data = match_params.slice(
      :played_at,
      :location_id,
      :score_sets_a_attributes,
      :score_sets_b_attributes,
      :match_players_a_attributes,
      :match_players_b_attributes
    )
    # Only mark for destruction if both score sets are blank
    data[:score_sets_a_attributes].each do |_, v|
      if v[:score].blank?
        score_b = data[:score_sets_b_attributes].values.find do |b|
          b[:position] == v[:position]
        end

        if score_b[:score].blank?
          v[:_destroy] = true
          score_b[:_destroy] = true
        end
      end
    end

    data
  end
end
