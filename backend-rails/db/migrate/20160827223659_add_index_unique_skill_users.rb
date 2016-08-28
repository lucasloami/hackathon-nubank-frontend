class AddIndexUniqueSkillUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :skill_users, [:skill_id, :user_id], unique: true
  end
end
