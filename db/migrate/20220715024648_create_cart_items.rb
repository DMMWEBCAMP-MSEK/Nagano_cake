class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :item, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :amount, null: false, default: ""

      t.timestamps
    end
    add_index :cart_items, :id,                   unique: true
  end
end
