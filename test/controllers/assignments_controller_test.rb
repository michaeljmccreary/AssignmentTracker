require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment = assignments(:one)
    @classroom = classrooms(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get assignments_url
    assert_response :success
    assert_select "h1", "My Assignments"
  end

  test "should get new" do
    get new_assignment_url(classroom_id: @classroom.id)
    assert_response :success
  end

  test "should create assignment" do
    assert_difference("Assignment.count") do
      post assignments_url, params: { 
        assignment: { 
          classroom_id: @classroom.id, 
          due_date: @assignment.due_date, 
          progress: @assignment.progress, 
          status: @assignment.status, 
          title: "New Test Assignment",
          description: "Test description"
        } 
      }
    end

    assert_redirected_to classroom_url(@classroom)
  end

  test "should show assignment" do
    get assignment_url(@assignment)
    assert_response :success
    assert_select "h1", /#{@assignment.title}/
  end

  test "should get edit" do
    get edit_assignment_url(@assignment)
    assert_response :success
  end

  test "should update assignment" do
    patch assignment_url(@assignment), params: { 
      assignment: { 
        classroom_id: @assignment.classroom_id, 
        due_date: @assignment.due_date, 
        progress: 75, 
        status: "In progress", 
        title: "Updated Title",
        description: "Updated description"
      } 
    }
    assert_redirected_to assignment_url(@assignment)
    
    @assignment.reload
    assert_equal "Updated Title", @assignment.title
    assert_equal 75, @assignment.progress
  end

  test "should destroy assignment" do
    assert_difference("Assignment.count", -1) do
      delete assignment_url(@assignment)
    end

    assert_redirected_to assignments_url
  end

  test "should filter assignments by status" do
    get assignments_url, params: { status: "In progress" }
    assert_response :success
  end

  test "should filter assignments by classroom" do
    get assignments_url, params: { classroom_id: @classroom.id }
    assert_response :success
  end

  test "should sort assignments by due date" do
    get assignments_url, params: { sort_by: "due_date" }
    assert_response :success
  end
end
