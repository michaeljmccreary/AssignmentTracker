require "application_system_test_case"

class ClassroomsTest < ApplicationSystemTestCase
  setup do
    @classroom = classrooms(:one)
    @user = users(:one)
    login_as(@user, scope: :user)
  end

  test "visiting the index" do
    visit classrooms_url
    assert_selector "h1", text: "My Classrooms"
  end

  test "should create classroom" do
    visit classrooms_url
    click_on "Add New Classroom"

    fill_in "Name", with: "New System Test Classroom"
    click_on "Create Classroom"

    assert_text "Classroom was successfully created"
  end

  test "should update Classroom" do
    visit classroom_url(@classroom)
    click_on "Edit Classroom", match: :first

    fill_in "Name", with: "Updated Classroom Name"
    click_on "Update Classroom"

    assert_text "Classroom was successfully updated"
    assert_text "Updated Classroom Name"
  end

  test "should destroy Classroom" do
    visit classroom_url(@classroom)

    accept_confirm do
      click_on "Delete Classroom", match: :first
    end

    assert_text "Classroom was successfully destroyed"
  end

  test "should display classroom assignments" do
    visit classroom_url(@classroom)

    assert_text @classroom.name
    # Check for assignments section
    assert_selector "h2", text: "Assignments"
  end

  test "should navigate to add assignment from classroom" do
    visit classroom_url(@classroom)
    click_on "Add New Assignment"

    assert_selector "h1", text: "New Assignment"
  end
end
