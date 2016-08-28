class Message < ApplicationRecord
    belongs_to :mission, optional: true
    belongs_to :task, optional: true

    has_many :users, through: :message_users
    has_many :message_users
end
