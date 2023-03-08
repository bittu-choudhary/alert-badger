class CreateNotificationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_types, id: :uuid do |t|
      t.string :name, unique: true, null: false
      t.string :description

      t.timestamps
    end
  end
end
