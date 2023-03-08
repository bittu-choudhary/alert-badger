class SlackNotifierService < ApplicationService
    attr_reader :alert, :slack_config

    def initialize(alert)
        @alert = alert
        @slack_config = SlackIntegration.find_by(client: alert.project.client)
    end

    def send
        notification = NotificationType.find_by(name: alert.alert_type)
        sender = User.find_by(email: "admin@example.com")
        receivers = SlackNotificationReceiver.where(project: alert.project, notification_type: notification)
        text = "The message sent to #{alert.payload["Email"]} was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content."
        message_data = []
        receivers.each do |receiver|
            NotificationDetail.create!(
                project: alert.project,
                sender: sender,
                receiver: receiver,
                message: text,
                notification_type: notification,
                alert_detail: alert
            )

            message_data << {
                channel: receiver.channel_name,
                text: text,
                as_user: true}
        end
        SlackNotifierJob.perform_later(slack_config, message_data)
    end

end