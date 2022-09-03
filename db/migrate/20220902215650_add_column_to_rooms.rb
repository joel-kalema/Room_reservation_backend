class AddColumnToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :price, :decimal
  end
end
