class AddNotNullConstrainListId < Sequel::Migration
  def up
    alter_table(:tasks) do
      set_column_not_null :user_id
      set_column_not_null :list_id
    end
  end

  def down
    alter_table(:tasks) do
      set_column_allow_null :user_id
      set_column_allow_null :list_id
    end
  end
end