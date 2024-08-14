class AddUniqToNombreProducto < ActiveRecord::Migration[7.2]
  def change
    add_index :productos, :nombre, unique: true
  end
end
