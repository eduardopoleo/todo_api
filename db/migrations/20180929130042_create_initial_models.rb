class CreateInitialModels < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      column :name, String
      column :email, String, unique: true
      column :password_digest, String

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :email
    end

    create_table :lists do
      primary_key :id
      column :name, String
      column :user_id, :integer

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :user_id
    end

    create_table :tasks do
      primary_key :id
      column :user_id, :integer
      column :list_id, :integer
      column :name, String
      column :completed, :boolean

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :list_id
      index :user_id
    end
  end

  def down
    drop_table :users
    drop_table :lists
    drop_table :tasks
  end
end