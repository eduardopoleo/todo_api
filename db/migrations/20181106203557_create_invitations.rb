class CreateInvitations < Sequel::Migration
 def up
    create_table :invitations do
      primary_key :id
      column :email, String, null: false
      column :token, String, null: false
      column :user_id, Integer
      column :group_id, Integer
      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :token
    end
  end

  def down
    drop_table :invitations
  end
end