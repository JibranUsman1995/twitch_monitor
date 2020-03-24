class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.text :message
      t.integer :sub_plan
      t.string :sub_type
      t.timestamps
    end
  end
end
