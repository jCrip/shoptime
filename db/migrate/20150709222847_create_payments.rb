class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :order_id
      t.string :session_id
      t.references :product, index: true, foreign_key: true
      t.string :transaction_id
      t.integer :amount
      t.integer :authorization
      t.integer :card_last_numbers
      t.boolean :status

      t.timestamps null: false
    end
  end
end
