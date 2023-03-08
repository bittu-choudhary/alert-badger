class NotificationType < ApplicationRecord
    has_many :slack_notification_receiver
    has_many :notification_details
end
