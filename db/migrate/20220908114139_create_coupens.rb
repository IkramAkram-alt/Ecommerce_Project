class CreateCoupens < ActiveRecord::Migration[6.0]
  def change
    create_table :coupens do |t|
      t.float :discount
      t.string :coupen_code

      t.timestamps
    end
  end
end
