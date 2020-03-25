class SoundAttachment < ApplicationRecord
  mount_uploader :attachment, SoundUploader
  mount_base64_uploader :attachment, SoundUploader
end
