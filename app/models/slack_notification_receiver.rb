class SlackNotificationReceiver < ApplicationRecord
  belongs_to :project
  belongs_to :notification_type
  belongs_to :slack_integration
  has_many :notification_details, as: :receiver

end
