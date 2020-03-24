class CreatePointPerDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :point_per_donations do |t|
      t.integer :value
    end
  end
end
