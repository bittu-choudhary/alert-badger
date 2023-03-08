class CreateSlackIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_integrations, id: :uuid do |t|
      t.belongs_to :client, null: false, foreign_key: true, type: :uuid
      t.string :workspace_name
      t.string :api_token, null: false, unique: true

      t.timestamps
    end
  end
end
