class CreateAlertDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :alert_details, id: :uuid do |t|
      t.string :name
      t.string :alert_type
      t.string :description
      t.string :from
      t.belongs_to :project, null: false, foreign_key: true, type: :uuid
      t.jsonb :payload

      t.timestamps
    end
  end
end
