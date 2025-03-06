Sequel.migration do

    up do
      alter_table(:date) do
        add_column(:expression_is_machine_generated, FalseClass, :default => 0)
      end
    end
  
    down do
        alter_table(:date) do
            drop_column(:expression_is_machine_generated, FalseClass)
        end
    end
  
  end
