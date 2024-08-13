class Usuario < ApplicationRecord
  has_secure_password

  validates :nombre, presence: true
  validates :correo, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: {minimum:6}
end
