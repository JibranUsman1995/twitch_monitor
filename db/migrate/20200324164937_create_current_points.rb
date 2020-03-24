class CreateCurrentPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :current_points do |t|
      t.integer :value
    end
  end
end
