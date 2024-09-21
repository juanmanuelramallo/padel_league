class MatchResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :played_at
  attribute :draft, index: false
  attribute :created_at, form: false, index: false
  attribute :updated_at, form: false, index: false

  # Associations
  attribute :location
  attribute :match_players, index: false
  attribute :score_sets, index: false

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
