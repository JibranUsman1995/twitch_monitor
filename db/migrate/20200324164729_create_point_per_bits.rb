class CreatePointPerBits < ActiveRecord::Migration[5.2]
  def change
    create_table :point_per_bits do |t|
      t.integer :value
    end
  end
end
