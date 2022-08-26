class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :city
      t.integer :duration
      t.date :date_reserved
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
