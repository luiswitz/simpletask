require 'rails_helper'

RSpec.describe "delete", :type => :feature do
  before do
    @task = FactoryGirl.create(:task)
    visit root_path
  end

  it "deletes a task" do
    click_link "DELETE"

    expect(page).to have_content("Task was successfully destroyed.")
  end
end