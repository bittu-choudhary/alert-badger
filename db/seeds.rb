# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

slack_api_token = # <your-slack-api-token>
channel_name = "#testing-honeybadger" # <your-slack-channel-name-with-#>
basic_auth_secret_token = "123secret" # <your-preferred-secret-token>

admin = User.create!(email: "admin@example.com", password: "admin123", first_name: "Admin", is_admin: true)
user = User.create!(email: "user@example.com", password: "secret123", first_name: "Bob", is_admin: false)
client = Client.create!(name: "Company X", user: user)
project = Project.create!(title: "Project X", client: client, secret_token: basic_auth_secret_token)
slack_config = SlackIntegration.create!(client: client, workspace_name: "test slack", api_token: slack_api_token)
notification_type = NotificationType.create!(name: "SpamNotification", description: "Spam notifications")
slack_receivers = SlackNotificationReceiver.create!(project: project, notification_type: notification_type, slack_integration: slack_config, channel_name: channel_name)
