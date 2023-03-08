class Client < ApplicationRecord
  belongs_to :user
  has_many :slack_integrations
  has_many :projects
end
