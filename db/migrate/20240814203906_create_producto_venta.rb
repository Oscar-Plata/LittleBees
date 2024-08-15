class CreateProductoVenta < ActiveRecord::Migration[7.2]
  def change
    create_table :producto_venta do |t|
      t.belongs_to :venta, null: false, foreign_key: true
      t.belongs_to :producto, null: false, foreign_key: true
      t.integer :cantidad

      t.timestamps
    end
  end
end
