class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
    end

    create_table :lists do |t|
      t.string :name
      t.integer :user_id
    end

    create_table :tasks do |t|
      t.integer :list_id
      t.integer :user_id
      t.string :name
      t.boolean :completed
    end

    add_index(:users, :email)
    add_index(:lists, :user_id)
    add_index(:tasks, :list_id)
  end
end
