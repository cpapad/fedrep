class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      t.timestamps
      t.string :user_urn
      t.integer :exp_count, :default => 0
      t.float :credibility, :default => 0.5
    end
  end
end
