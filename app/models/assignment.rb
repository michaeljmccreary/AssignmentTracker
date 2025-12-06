class Assignment < ApplicationRecord
  belongs_to :classroom

  validates :title, :due_date, presence: true

  before_save :adjust_progress_based_on_status

  private

  def adjust_progress_based_on_status
    if status == "Not started"
      self.progress = 0
    elsif status == "Completed"
      self.progress = 100
    end
  end
end
