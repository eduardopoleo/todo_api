class CreateSessionTable < Sequel::Migration
  def up
    create_table :sessions do
      primary_key :id
      column :token, String, null: false
      column :user_id, Integer, null: false
      column :created_at, :timestamp, null: false

      index :token
    end
  end

  def down
    drop_table :sessions
  end
end