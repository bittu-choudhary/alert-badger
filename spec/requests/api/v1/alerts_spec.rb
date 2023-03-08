require 'rails_helper'

RSpec.describe "Api::V1::AlertsController", type: :request do
  after do
    WebMock.reset!
  end

  let(:spam_payload) {{
    "RecordType": "Bounce",
    "Type": "SpamNotification",
    "TypeCode": 512,
    "Name": "Spam notification",
    "Tag": "",
    "MessageStream": "outbound",
    "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
    "Email": "zaphod@example.com",
    "From": "notifications@honeybadger.io",
    "BouncedAt": "2023-02-27T21:41:30Z",
  }}

  let(:other_payload) {{
    "RecordType": "Bounce",
    "MessageStream": "outbound",
    "Type": "HardBounce",
    "TypeCode": 1,
    "Name": "Hard bounce",
    "Tag": "Test",
    "Description": "The server was unable to deliver your message (ex: unknown user, mailbox not found).",
    "Email": "arthur@example.com",
    "From": "notifications@honeybadger.io",
    "BouncedAt": "2019-11-05T16:33:54.9070259Z",
  }}

  let(:project) {Project.first}

  context "with spam_payload" do
    it "should send slack message" do
      encoded_credentials = ActionController::HttpAuthentication::Basic.encode_credentials(project.title,project.secret_token)
      post api_v1_alerts_path, params: {alert: spam_payload}, headers: { Authorization: encoded_credentials }
      expect(NotificationDetail.last.notification_type.name).to eq("SpamNotification")
    end
  end

  context "with spam_payload" do
    it "should not send slack message" do
      encoded_credentials = ActionController::HttpAuthentication::Basic.encode_credentials(project.title,project.secret_token)
      post api_v1_alerts_path, params: {alert: other_payload}, headers: { Authorization: encoded_credentials }
      expect(AlertDetail.last.alert_type).to eq("HardBounce")
    end
  end

end
