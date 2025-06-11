class Project < ApplicationRecord
  belongs_to :user
  has_many :project_events, dependent: :destroy

  enum status: {
    idle: 0,
    in_progress: 1,
    on_hold: 2,
    completed: 3,
    archived: 4
  }
end
