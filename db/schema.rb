Sequel.migration do
  change do
    create_table(:lists, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :size=>32, :fixed=>true
      Integer :user_id
      DateTime :created_at
      DateTime :updated_at
      
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
      String :name, :size=>32, :fixed=>true
      TrueClass :completed
      DateTime :created_at
      DateTime :updated_at
      
      index [:list_id]
      index [:user_id]
    end
    
    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :size=>32, :fixed=>true
      String :email, :size=>1, :fixed=>true
      String :password_digest, :size=>1, :fixed=>true
      DateTime :created_at
      DateTime :updated_at
      
      index [:email]
      index [:email], :name=>:users_email_key, :unique=>true
    end
  end
end
