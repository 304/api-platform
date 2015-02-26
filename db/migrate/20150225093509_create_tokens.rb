class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens, id: false, primary_key: :id do |t|
      t.string :id, limit: 20, null: false
      t.string :signature, limit: 100, null: false
      t.string :user_id, limit: 20, null: false
      t.datetime :expired_at, null: false

      t.timestamps null: false
    end

    add_index :tokens, :id, unique: true
    add_index :tokens, :user_id
  end
end
