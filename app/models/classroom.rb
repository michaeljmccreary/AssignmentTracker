class Classroom < ApplicationRecord
  belongs_to :user
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
end
