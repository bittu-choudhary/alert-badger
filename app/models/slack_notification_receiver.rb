class SlackNotificationReceiver < ApplicationRecord
  belongs_to :project
  belongs_to :notification_type
  belongs_to :slack_integration
end
