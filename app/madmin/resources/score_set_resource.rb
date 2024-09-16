class ScoreSetResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :score
  attribute :team_id
  attribute :score_1
  attribute :score_2
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :match

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
    if record.score.present?
      "#{record.score} (#{record.team_id}) ##{record.id}"
    else
      "#{record.score_1} - #{record.score_2} ##{record.id}"
    end
  end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
