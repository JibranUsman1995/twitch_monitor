class CreateSoundAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :sound_attachments do |t|
      t.string :attachment
    end
  end
end
