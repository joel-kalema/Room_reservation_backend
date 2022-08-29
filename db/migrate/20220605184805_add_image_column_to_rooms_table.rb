class AddImageColumnToRoomsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :image, :string
  end
end
