class NotificationDetail < ApplicationRecord
  belongs_to :project
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  belongs_to :notification_type
  belongs_to :alert_detail
end
