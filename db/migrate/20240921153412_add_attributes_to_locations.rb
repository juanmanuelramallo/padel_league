class AddAttributesToLocations < ActiveRecord::Migration[7.2]
  def change
    change_table :locations do |t|
      t.string :latitude, null: false, default: ''
      t.string :longitude, null: false, default: ''
      t.string :address, null: false, default: ''
    end
  end
end
