class StreamlabLog < ApplicationRecord
  validates :message, presence: true
end