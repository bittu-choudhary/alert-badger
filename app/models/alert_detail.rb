class AlertDetail < ApplicationRecord
  belongs_to :project
  has_one :notification_detail

  def is_spam?
    spam_detector = SpamDetectionService.new(self)
    spam_detector.inspect
  end
  
end
