class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment, only: %i[ show edit update destroy ]

  # GET /assignments or /assignments.json
  def index
    # Only get assignments from the current user's classrooms
    @classrooms = current_user.classrooms
    @assignments = Assignment.joins(:classroom).where(classrooms: { user_id: current_user.id })

    # Filter by status
    if params[:status].present? && params[:status] != "all"
      @assignments = @assignments.where(status: params[:status])
    end

    # Filter by classroom
    if params[:classroom_id].present? && params[:classroom_id] != "all"
      # Verify the classroom belongs to the current user
      if @classrooms.exists?(id: params[:classroom_id])
        @assignments = @assignments.where(classroom_id: params[:classroom_id])
      end
    end

    # Sort by due date
    if params[:sort_by] == "due_date"
      @assignments = @assignments.order(due_date: :asc)
    else
      @assignments = @assignments.order(created_at: :desc)
    end
  end

  # GET /assignments/1 or /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @classroom = current_user.classrooms.find(params[:classroom_id])
    @assignment = @classroom.assignments.build
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments or /assignments.json
  def create
    @classroom = current_user.classrooms.find(params[:assignment][:classroom_id])
    @assignment = @classroom.assignments.build(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @classroom, notice: "Assignment was successfully created." }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: "Assignment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy!

    respond_to do |format|
      format.html { redirect_to assignments_path, notice: "Assignment was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      # Only allow access to assignments that belong to the current user's classrooms
      @assignment = Assignment.joins(:classroom).where(classrooms: { user_id: current_user.id }).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.expect(assignment: [ :title, :due_date, :status, :progress, :classroom_id, :description ])
    end
end
