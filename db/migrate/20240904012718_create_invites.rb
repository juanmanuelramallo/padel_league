class CreateInvites < ActiveRecord::Migration[7.2]
  def change
    create_table :invites do |t|
      t.references :invitee, null: false, foreign_key: { to_table: :players }
      t.references :inviter, null: false, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
