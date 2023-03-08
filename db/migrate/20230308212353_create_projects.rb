class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title, unique: true, null: false
      t.belongs_to :client, null: false, foreign_key: true, type: :uuid
      t.string :secret_token, null: false, unique: true
      
      t.timestamps
    end
  end
end
