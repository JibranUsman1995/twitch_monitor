class CreatePointPerSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :point_per_subscriptions do |t|
      t.integer :value
      t.string :sub_type
    end
  end
end
