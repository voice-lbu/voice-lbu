class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 64, null: false
      t.string :email, limit: 64, null: false
      t.string :password_digest, limit: 64
      t.string :password_salt, limit: 64
      t.string :phone, limit: 16

      t.timestamps
    end
  end
end
