class CreateVenta < ActiveRecord::Migration[7.2]
  def change
    create_table :venta do |t|
      t.string :fecha
      t.string :hora
      t.float :total

      t.timestamps
    end
  end
end
