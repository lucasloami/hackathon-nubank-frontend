class AddImageToSkill < ActiveRecord::Migration[5.0]
  def self.up
    add_column :skills, :image_url, :string
  end

  def self.down
    remove_column :skills, :image_url
  end
end
