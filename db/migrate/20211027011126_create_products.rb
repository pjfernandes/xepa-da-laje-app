class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :unit_price
      t.integer :quantity
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
