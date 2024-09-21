class LocationResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :image, index: false
  attribute :latitude, index: false
  attribute :longitude, index: false
  attribute :address, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
    "#{record.name} ##{record.id}"
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
