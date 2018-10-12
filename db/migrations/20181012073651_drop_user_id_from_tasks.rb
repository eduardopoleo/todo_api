class DropUserIdFromTasks < Sequel::Migration
  def up
    alter_table(:tasks) do
      drop_column :user_id
    end
  end

  def down
    alter_table(:tasks) do
      add_column :user_id, Integer, default: nil 
    end
  end
end