class Task < ApplicationRecord
    belongs_to :mission
    has_many :messages
end
