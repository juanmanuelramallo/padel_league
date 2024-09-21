class AddDraftToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :draft, :boolean, default: false
  end
end
