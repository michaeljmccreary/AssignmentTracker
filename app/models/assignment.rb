class Assignment < ApplicationRecord
  belongs_to :classroom

  validates :title, :due_date, presence: true
end
