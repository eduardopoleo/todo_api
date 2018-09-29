class CreateInitialModel < Sequel::Migration
  def up
    create_table :sessions_by_eduardo do
      primary_key :id
      String :session_id, :size => 32, :unique => true
      DateTime :created_at
      text :data
    end
  end

  def down
    self << 'DROP TABLE sessions_by_eduardo'
  end
end