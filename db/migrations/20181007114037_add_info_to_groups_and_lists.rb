class AddInfoToGroupsAndLists < Sequel::Migration
  def up
    alter_table(:lists) do
      add_column :group_id, Integer, default: nil
      add_index :group_id

      add_column :task_count, Integer, default: 0
      add_column :last_task_name, :text
    end
  end

  def down
    alter_table(:lists) do
      remove_column :group_id
      remove_column :task_count
      remove_column :last_task_name
    end
  end
end