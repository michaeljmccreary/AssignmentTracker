class AddDescriptionToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :description, :text
  end
end
