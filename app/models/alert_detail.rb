class AlertDetail < ApplicationRecord
  belongs_to :project
  has_one :notification_detail
end
