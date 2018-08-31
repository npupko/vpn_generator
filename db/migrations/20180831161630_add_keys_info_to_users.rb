Hanami::Model.migration do
  change do
    alter_table(:users) do
      add_column :keys_generated, Integer, default: 0
      add_column :last_key_generated_at, DateTime
    end
  end
end
