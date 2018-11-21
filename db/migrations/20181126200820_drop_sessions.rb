class DropSessions < Sequel::Migration
  def up
    drop_table(:sessions)
  end

  def down
    create_table :sessions do
      primary_key :id
      column :token, String, null: false
      column :user_id, Integer, null: false
      column :created_at, :timestamp, null: false

      index :token
    end
  end
end