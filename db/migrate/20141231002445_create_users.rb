class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false, primary_key: :id do |t|
      t.string :id, limit: 20, null: false
      t.string :name, limit: 50, null: false
      t.string :email, limit: 100, null: false
      t.string :password_digest, limit: 100, null: false

      t.timestamps null: false
    end

    add_index :users, :id, unique: true
    add_index :users, :email, unique: true
  end
end
