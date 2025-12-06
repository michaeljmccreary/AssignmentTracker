require "application_system_test_case"

class AssignmentsTest < ApplicationSystemTestCase
  setup do
    @assignment = assignments(:one)
    @classroom = classrooms(:one)
    @user = users(:one)
    login_as(@user, scope: :user)
  end

  test "visiting the index" do
    visit assignments_url
    assert_selector "h1", text: "My Assignments"
  end

  test "should create assignment" do
    visit classroom_url(@classroom)
    click_on "Add New Assignment"

    fill_in "Title", with: "New System Test Assignment"
    fill_in "Due date", with: 30.days.from_now.to_date
    select "Not started", from: "Status"
    fill_in "Description", with: "This is a test description"

    click_on "Create Assignment"

    assert_text "Assignment was successfully created"
  end

  test "should update Assignment" do
    visit assignment_url(@assignment)
    click_on "Edit Assignment", match: :first

    fill_in "Title", with: "Updated Assignment Title"
    fill_in "Progress", with: 80
    select "In progress", from: "Status"
    fill_in "Description", with: "Updated description"

    click_on "Update Assignment"

    assert_text "Assignment was successfully updated"
    assert_text "Updated Assignment Title"
  end

  test "should destroy Assignment" do
    visit assignment_url(@assignment)

    accept_confirm do
      click_on "Delete Assignment", match: :first
    end

    assert_text "Assignment was successfully destroyed"
  end

  test "should filter assignments by status" do
    visit assignments_url

    select "In progress", from: "Status"
    click_on "Apply Filters"

    assert_selector "h1", text: "My Assignments"
  end

  test "should display assignment details" do
    visit assignment_url(@assignment)

    assert_text @assignment.title
    assert_text @assignment.classroom.name
    assert_text "Assignment Information"
  end

  test "should show progress bar" do
    visit assignment_url(@assignment)

    assert_selector ".progress-bar"
  end
end
