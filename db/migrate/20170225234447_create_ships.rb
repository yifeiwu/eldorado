class CreateShips < ActiveRecord::Migration[5.0]
  def change
    create_table :ships do |t|
      t.string :ship_name
      t.integer :ship_capacity

      t.timestamps
    end
  end
end
