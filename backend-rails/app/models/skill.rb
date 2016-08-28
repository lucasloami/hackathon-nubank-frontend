class Skill < ApplicationRecord
    has_many :users, through: :skill_users
    has_many :skill_users
end
