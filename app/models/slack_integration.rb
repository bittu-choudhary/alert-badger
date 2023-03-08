class SlackIntegration < ApplicationRecord
  belongs_to :client
  encrypts :api_token
end
