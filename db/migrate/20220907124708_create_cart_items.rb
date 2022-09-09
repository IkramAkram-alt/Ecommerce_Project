class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end