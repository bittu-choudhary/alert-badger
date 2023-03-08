class CreateNotificationDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_details, id: :uuid do |t|
      t.belongs_to :project, null: false, foreign_key: true, type: :uuid
      t.references :sender, null: false, polymorphic: true, type: :uuid
      t.references :receiver, null: false, polymorphic: true, type: :uuid
      t.string :message
      t.belongs_to :notification_type, null: false, foreign_key: true, type: :uuid
      t.jsonb :payload
      t.belongs_to :alert_detail, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
