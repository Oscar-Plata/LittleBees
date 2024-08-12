class AddNullFalseToProductoFields < ActiveRecord::Migration[7.2]
  def change
    change_column_null :productos, :nombre, false
    change_column_null :productos, :descripcion, false
    change_column_null :productos, :precio, false
  end
end
