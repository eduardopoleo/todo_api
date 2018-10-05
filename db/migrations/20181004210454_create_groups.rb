class CreateGroups < Sequel::Migration
  def up
    create_table :groups do
      primary_key :id
      column :name, String
      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false
    end

    create_table :user_groups do
      primary_key :id
      column :user_id, Integer
      column :group_id, Integer
      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :group_id
      index :user_id
    end
  end

  def down
    drop_table :groups
    drop_table :user_groups
  end
end