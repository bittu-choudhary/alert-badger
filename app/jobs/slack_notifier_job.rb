class SlackNotifierJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 10, jitter: 0.30


  def perform(*args)
    slack_config = args[0]
    message_data = args[1]
    Slack.configure do |config|
      config.token = slack_config.api_token
    end
    client = Slack::Web::Client.new
    message_data.each {|message| client.chat_postMessage(message) }
  end
end
