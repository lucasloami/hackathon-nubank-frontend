class AddTitleToTasks < ActiveRecord::Migration[5.0]
  def self.up
    add_column :tasks, :title, :string
  end

  def self.down
    remove_column :tasks, :title
  end
end
