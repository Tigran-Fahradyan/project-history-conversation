class CreateProjectEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :project_events do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :event_type
      t.text :content
      t.string :from_status
      t.string :to_status

      t.timestamps
    end
  end
end
