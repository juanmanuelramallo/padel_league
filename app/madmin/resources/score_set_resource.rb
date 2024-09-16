class ScoreSetResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :position
  attribute :score
  attribute :team_id
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :match

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
    "#{record.position}. #{record.score} (#{record.team_id}) ##{record.id}"
  end

  def self.default_sort_column
    "position"
  end

  def self.default_sort_direction
    "asc"
  end
end
