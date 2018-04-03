class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|

      t.string :service_name
      t.integer :testbed_id
    end
  end
end
