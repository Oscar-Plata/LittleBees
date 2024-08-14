class AddUniqToCorreoUsuario < ActiveRecord::Migration[7.2]
  def change
    add_index :usuarios, :correo, unique: true
  end
end
