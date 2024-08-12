class Producto < ApplicationRecord
  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :precio, presence: true
end
