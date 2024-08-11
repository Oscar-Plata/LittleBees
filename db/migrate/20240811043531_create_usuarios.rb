class CreateUsuarios < ActiveRecord::Migration[7.2]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :correo
      t.string :password_digest

      t.timestamps
    end
  end
end
