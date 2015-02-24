class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :member_id, null: false
      t.integer :amount, null: false
      t.datetime :sent_at
      t.datetime :paid_at

      t.timestamps
    end
  end
end
