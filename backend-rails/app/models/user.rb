class User < ActiveRecord::Base
  # Include default devise modules.
  attr_accessor :total_xp, :has_mission

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :skills, through: :skill_users
  has_many :skill_users

  has_many :messages, through: :message_users
  has_many :message_users
  
  has_many :missions

  belongs_to :role, optional: true
  has_one :mentor, class_name: "User", foreign_key: :mentor_id

  def total_xp
    total = 0
      self.missions.each{ |mission|
        mission.tasks.each { |task|
          if task.completed
            total = total + task.xp.to_i
          end
        }
      }
      total
  end

  def has_mission
    self.missions.count > 0
  end
end
