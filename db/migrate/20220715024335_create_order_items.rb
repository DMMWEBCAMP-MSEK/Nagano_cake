class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :amount, null: false, default: ""
      t.integer :price, null: false, default: ""
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
    add_index :order_items, :id,                   unique: true
  end
end
