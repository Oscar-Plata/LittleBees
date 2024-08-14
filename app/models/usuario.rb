class Usuario < ApplicationRecord
  before_save :data_trim
  before_save :downcase_attributes

  has_secure_password

  validates :nombre, presence: true,
  format:{
    with: /\A[a-zA-Z0-9\s\-]+\z/,
    message: :invalid
  }
  validates :correo, presence: true, uniqueness: true,
  format:{
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: :invalid
  }
  validates :password_digest, presence: true, length: {minimum:6}

  

  private

  def downcase_attributes
    self.correo = correo.downcase
  end

  def data_trim
    self.nombre = nombre.strip
    self.correo = correo.strip
    self.password = password.strip
  end

  
end
