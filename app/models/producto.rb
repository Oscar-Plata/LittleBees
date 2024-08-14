class Producto < ApplicationRecord
  before_save :data_trim 
  has_one_attached :foto

  validates :nombre, presence: true, uniqueness: true, format:{
    with: /\A[a-zA-Z0-9\s\-]+\z/,
    message: :invalid
  }
  validates :descripcion, presence: true
  validates :precio, presence: true

  private

  def data_trim
    self.nombre = nombre.strip
    self.descripcion = descripcion.strip
  end
end
