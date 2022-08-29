class AddUserToRoom < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :user, foreign_key: true
  end
end
