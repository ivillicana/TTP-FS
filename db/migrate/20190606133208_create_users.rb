class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :balance, default: 5000.00, precision: 15, scale: 2

      t.timestamps
    end
  end
end
