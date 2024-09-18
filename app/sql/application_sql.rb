class ApplicationSQL
  include ActiveModel::AttributeAssignment

  def initialize(data = {})
    assign_attributes(data)
  end

  def execute
    ActiveRecord::Base.connection.select_all(
      sql,
      name,
      bind_values
    )
  end

  def name
    self.class.name
  end
end
