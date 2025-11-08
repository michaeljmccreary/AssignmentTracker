class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.string :title
      t.date :due_date
      t.string :status
      t.integer :progress
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
