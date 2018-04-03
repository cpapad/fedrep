class CreateExperiments < ActiveRecord::Migration[5.1]
  def change
    create_table :experiments do |t|

      t.timestamps
      t.string :slice_urn
      t.boolean :rated, :default => false
      t.string :rstart
      t.string :rend
      t.string :user_urn
      t.integer :user_id


    end
  end
end
