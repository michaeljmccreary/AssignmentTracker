require "test_helper"

class ClassroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classroom = classrooms(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get classrooms_url
    assert_response :success
    assert_select "h1", "My Classrooms"
  end

  test "should get new" do
    get new_classroom_url
    assert_response :success
  end

  test "should create classroom" do
    assert_difference("Classroom.count") do
      post classrooms_url, params: { 
        classroom: { 
          name: "New Test Classroom", 
          user_id: @user.id 
        } 
      }
    end

    assert_redirected_to classroom_url(Classroom.last)
  end

  test "should show classroom" do
    get classroom_url(@classroom)
    assert_response :success
    assert_select "h1", /#{@classroom.name}/
  end

  test "should get edit" do
    get edit_classroom_url(@classroom)
    assert_response :success
  end

  test "should update classroom" do
    patch classroom_url(@classroom), params: { 
      classroom: { 
        name: "Updated Classroom Name", 
        user_id: @classroom.user_id 
      } 
    }
    assert_redirected_to classroom_url(@classroom)
    
    @classroom.reload
    assert_equal "Updated Classroom Name", @classroom.name
  end

  test "should destroy classroom" do
    assert_difference("Classroom.count", -1) do
      delete classroom_url(@classroom)
    end

    assert_redirected_to classrooms_url
  end

  test "should display classroom assignments" do
    get classroom_url(@classroom)
    assert_response :success
    # Check that assignments are displayed
    @classroom.assignments.each do |assignment|
      assert_select "div", text: /#{assignment.title}/
    end
  end
end
