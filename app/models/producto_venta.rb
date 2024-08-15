class ProductoVenta < ApplicationRecord
  belongs_to :venta
  belongs_to :producto


  def total 
    producto.precio * cantidad
  end
end
