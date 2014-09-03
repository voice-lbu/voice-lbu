class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name, limit: 64, null: false
      t.string :address, limit: 64, null: false
      t.date :birthdate
      t.date :left_on
      t.string :postal_code, limit: 4
      t.string :post_office, limit: 64
      t.string :guardian_1, limit: 64
      t.string :guardian_2, limit: 64
      t.date :joined_on, null: false
      t.boolean :female, null: false
      t.string :email, limit: 64
      t.string :guardian_1_email, limit: 64
      t.string :guardian_2_email, limit: 64
      t.string :mobile, limit: 16
      t.string :guardian_1_mobile, limit: 16
      t.string :guardian_2_mobile, limit: 16

      t.timestamps
    end
  end
end
