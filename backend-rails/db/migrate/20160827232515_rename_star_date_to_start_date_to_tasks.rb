class RenameStarDateToStartDateToTasks < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :star_date, :start_date
  end
end
