class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.text :description
      t.string :goal
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :value
      t.belongs_to :user
      t.timestamps
    end
  end
end
