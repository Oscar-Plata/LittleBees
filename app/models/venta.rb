class Venta < ApplicationRecord
  has_many :productosventa, class_name: "ProductoVenta"
  has_many :productos, through: :productosventa


  def calcTotal
    productosventa.sum(&:total)
  end
end
