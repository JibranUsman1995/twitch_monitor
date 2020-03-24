class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.string :name
      t.string :currency
      t.integer :amount
      t.string :from_name
      t.string :from_id
    end
  end
end
