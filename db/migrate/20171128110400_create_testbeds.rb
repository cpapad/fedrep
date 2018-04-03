class CreateTestbeds < ActiveRecord::Migration[5.1]
  def change
    create_table :testbeds do |t|

      t.timestamps
      t.text :testbed_name
      t.text :tb_alias
      t.text :tb_urn
      t.text :am
      t.float :reputation, :default=>0.5
      t.integer :experiments, :default=>0
    end
  end
end
