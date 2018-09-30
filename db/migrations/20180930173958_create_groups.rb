class CreateGroups < Sequel::Migration
  def up
    create_table :groups do
      primary_key :id
      column :name, String
      column :creator_id, :integer

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false
    end
  end

  def down
  end
end