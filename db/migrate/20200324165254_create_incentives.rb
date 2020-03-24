class CreateIncentives < ActiveRecord::Migration[5.2]
  def change
    create_table :incentives do |t|
      t.integer :value
    end
  end
end
