class SoundAttachment < ApplicationRecord
  mount_uploader :attachment, SoundUploader
end
