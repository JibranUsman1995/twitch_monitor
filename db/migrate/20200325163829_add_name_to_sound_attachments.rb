class AddNameToSoundAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :sound_attachments, :name, :string
  end
end
