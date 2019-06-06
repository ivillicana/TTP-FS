class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.integer :shares_quantity
      t.decimal :price_per_share
      t.string :status

      t.timestamps
    end
  end
end
