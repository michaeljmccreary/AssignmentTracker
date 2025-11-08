class PagesController < ApplicationController
  def home
    if user_signed_in?
      @assignments = current_user.classrooms.includes(:assignments).flat_map(&:assignments).sort_by(&:due_date)
  end
end
end