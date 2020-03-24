class CreateHighScores < ActiveRecord::Migration[5.2]
  def change
    create_table :high_scores do |t|
      t.integer :value
    end
  end
end
