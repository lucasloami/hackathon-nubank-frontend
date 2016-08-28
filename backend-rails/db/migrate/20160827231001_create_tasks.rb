class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :category
      t.text :description
      t.decimal :value
      t.integer :xp
      t.datetime :star_date
      t.datetime :end_date
      t.string :prize
      t.boolean :accepted
      t.belongs_to :mission
      t.timestamps
    end
  end
end
