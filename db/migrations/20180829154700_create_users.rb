Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :messenger_id, Integer, null: false
      column :first_name, String
      column :last_name, String
      column :username, String
      column :language_code, String
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
