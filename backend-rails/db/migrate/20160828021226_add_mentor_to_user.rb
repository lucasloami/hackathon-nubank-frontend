class AddMentorToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :mentor_id, :integer
  end

  def self.down
    remove_column :users, :mentor_id
  end
end
