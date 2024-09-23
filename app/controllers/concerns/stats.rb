module Stats
  extend ActiveSupport::Concern

  MAX_RANGE = 1.year

  def player
    @player ||= begin
                  p = current_player if params[:player_id] == current_player.id.to_s
                  p ||= current_player
                    .friends
                    .find(params[:player_id])
                end
  end

  def date_range
    @date_range ||= start_date..end_date
  end

  def start_date
    @start_date ||=
      [ fetch_date(:from, Date.today - 1.month), end_date - MAX_RANGE ].max
  end

  def end_date
    @end_date ||= fetch_date(:to, Date.today)
  end

  def fetch_date(param_name, default_date)
    if date_params[param_name].present?
      Date.parse(params[param_name])
    else
      default_date
    end
  rescue Date::Error, ArgumentError
    default_date
  end

  def date_params
    params.permit(:from, :to)
  end
end
