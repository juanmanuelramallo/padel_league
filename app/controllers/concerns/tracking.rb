module Tracking
  extend ActiveSupport::Concern

  included do
    after_action :track_action
  end

  private

  def track_action
    ahoy.track "Action", request.path_parameters
  end
end
