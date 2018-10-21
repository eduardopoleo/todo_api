class AddValidColumnToSessions < Sequel::Migration
  def up
    alter_table(:sessions) do
      add_column :valid, TrueClass, default: true
      add_index :valid
    end
  end

  def down
    alter_table(:sessions) do
      drop_column :valid
    end
  end
end