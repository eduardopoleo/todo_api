class CreateInitialModels < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      column :name, :char, size: 32
      column :email, :char, size: 32, unique: true
      column :password_digest, :char, size: 256

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :email
    end

    create_table :lists do
      primary_key :id
      column :name, :char, size: 32
      column :user_id, :integer

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :user_id
    end

    create_table :tasks do
      primary_key :id
      column :user_id, :integer
      column :list_id, :integer
      column :name, :char, size: 32
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