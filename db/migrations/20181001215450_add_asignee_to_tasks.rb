class AddAsigneeToTasks < Sequel::Migration
  def up
    alter_table(:tasks) do
      add_column :assignee_id, Integer, default: nil
      add_index :assignee_id
      add_index :completed
    end
  end

  def down
    alter_table(:tasks) do
      drop_column :assignee_id
      remove_index :completed
    end
  end
end