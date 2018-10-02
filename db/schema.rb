Sequel.migration do
  change do
    create_table(:lists, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :text=>true
      Integer :user_id
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      
      index [:user_id]
    end
    
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:tasks, :ignore_index_errors=>true) do
      primary_key :id
      Integer :user_id
      Integer :list_id
      String :name, :text=>true
      TrueClass :completed
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      Integer :assignee_id
      
      index [:assignee_id]
      index [:completed]
      index [:list_id]
      index [:user_id]
    end
    
    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :text=>true
      String :email, :text=>true
      String :password_digest, :text=>true
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      
      index [:email]
      index [:email], :name=>:users_email_key, :unique=>true
    end
  end
end
