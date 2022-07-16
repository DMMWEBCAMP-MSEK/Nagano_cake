class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true
      t.string :name, null: false, default: ""
      t.text :introduction, null: false, default: ""
      t.integer :price, null: false, default: ""
      t.text :image, null: false
      t.integer :sales_status, null: false, default: 0

      t.timestamps
    end
    add_index :items, :id,                   unique: true
  end
end
