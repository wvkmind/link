class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, limit: 255, null: false
      t.string :password, limit: 255, default: 'no_password'
      t.integer :owner_id, null: false
      t.integer :map_type, null: false
      t.timestamps
    end
  end
end
