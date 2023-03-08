class SpamDetectionService < ApplicationService
    attr_reader :alert

    def initialize(alert)
        @alert = alert
    end

    def inspect
        alert.alert_type == "SpamNotification"
    end
end