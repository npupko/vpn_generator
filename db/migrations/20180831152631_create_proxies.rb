Hanami::Model.migration do
  change do
    create_table :proxies do
      primary_key :id

      column :ip, String, null: false
      column :port, Integer, null: false
      column :used, FalseClass, default: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
