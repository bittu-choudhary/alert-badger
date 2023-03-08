class NotificationDetail < ApplicationRecord
  belongs_to :project
  belongs_to :sender
  belongs_to :receiver
  belongs_to :notification_type
end
