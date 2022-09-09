class AddColCoupenToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :coupen, null: true, foreign_key: true
  end
end
