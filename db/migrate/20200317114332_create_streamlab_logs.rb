class CreateStreamlabLogs < ActiveRecord::Migration[5.2]
  def up
    create_table :streamlab_logs do |t|
      t.text :message
      t.timestamps
    end
  end

  def down
    drop_table :streamlab_logs
  end
end
