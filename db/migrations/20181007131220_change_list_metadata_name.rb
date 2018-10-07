class ChangeListMetadataName < Sequel::Migration
  def up
    alter_table(:lists) do
      rename_column :last_task_name, :last_added_task
    end
  end

  def down
    alter_table(:lists) do
      rename_column :last_added_task, :last_task_name
    end
  end
end