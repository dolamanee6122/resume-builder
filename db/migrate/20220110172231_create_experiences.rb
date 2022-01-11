class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :position
      t.date :start
      t.date :end
      t.text :description

      t.belongs_to :profile, index: true, foreign_key: true

      t.timestamps
    end
  end
end
