class Producto < ApplicationRecord
  has_one_attached :foto

  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :precio, presence: true
end
