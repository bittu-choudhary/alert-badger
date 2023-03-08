class AlertHandlerService < ApplicationService
    attr_reader :alert
    def initialize(alert)
        @alert = alert
    end

    def inspect
        if alert.is_spam?
            send_alert
        end
    end

    def send_alert
        slack_notifier = SlackNotifierService.new(alert)
        slack_notifier.send
    end
end