class CreateSlackNotificationReceivers < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_notification_receivers, id: :uuid do |t|
      t.belongs_to :project, null: false, foreign_key: true, type: :uuid
      t.string :channel_name, null: false
      t.belongs_to :notification_type, null: false, foreign_key: true, type: :uuid
      t.belongs_to :slack_integration, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
