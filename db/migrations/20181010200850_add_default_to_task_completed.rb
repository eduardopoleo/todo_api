class AddDefaultToTaskCompleted < Sequel::Migration
  def up
    alter_table(:tasks) do
      set_column_default :completed, false
    end
  end

  def down
    alter_table(:tasks) do
      set_column_default :completed, nil
    end
  end
end