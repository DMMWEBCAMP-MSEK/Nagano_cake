class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|
      #t.index[:shipping_address_id]
      t.references :customer, foreign_key: true
      t.string :post_code, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :name, null: false, default: ""

      t.timestamps
    end
    add_index :shipping_addresses, :id,                   unique: true
  end
end
