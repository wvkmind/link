class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login_name, limit: 255, null: false, index: { unique: true }
      t.string :password, limit: 64, null: false
      t.integer :level, default: 1
      t.string :name, limit: 255, null: false
      t.integer :role_type, null: false
      t.timestamps
    end
  end
end
