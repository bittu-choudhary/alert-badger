class SlackIntegration < ApplicationRecord
  belongs_to :client
  has_many :slack_notification_receiver
  encrypts :api_token
end
