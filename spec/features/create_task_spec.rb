require 'rails_helper'

RSpec.describe "creating tasks", :type => :feature do
  before do
    visit root_path
  end

  scenario "an user creates a new task" do
    click_link "New Task"
    fill_in "Description", with: "New Task"
    click_button "Create Task"

    expect(page).to have_content("Task was successfully created.")
  end

  scenario "an user fails to create a new task" do
    click_link "New Task"
    click_button "Create Task"

    expect(page).to have_content("Description can't be blank")
  end
end