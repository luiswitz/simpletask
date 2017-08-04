require 'rails_helper'

RSpec.describe "edit", :type => :feature, js: true do
  before do
    @task = FactoryGirl.create(:task, completed_at: nil)
    visit root_path
  end

  it "can change task description" do
    find("[data-behavior='task-description']").click
    fill_in "description_field", with: "Edited Task"
    find("h1").click
    @task.reload
    expect(@task.description).to eq("Edited Task")
  end

  it 'completes a task' do
    find("[data-behavior='task-toggle']").click
    @task.reload
    expect(@task.completed?).to be true
  end

  it 'mark a completed task as incomplete' do
    @task.update(completed_at: Time.now)
    find("[data-behavior='task-toggle']").click
    @task.reload
    expect(@task.completed?).to be false
  end
end