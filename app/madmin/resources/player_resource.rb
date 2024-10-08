class PlayerResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :phone
  attribute :email
  attribute :confirmed_at
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :password, index: false, show: false
  attribute :password_confirmation, index: false, show: false

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
