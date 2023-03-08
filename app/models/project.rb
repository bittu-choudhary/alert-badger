class Project < ApplicationRecord
  belongs_to :client
  has_many :alert_details
  has_many :notification_details
  has_many :slack_notification_receiver
  encrypts :secret_token

end
