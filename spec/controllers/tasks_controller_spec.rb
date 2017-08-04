require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "POST #create" do
    before do
      @task = FactoryGirl.build(:task)
      post :create, params: { task: { description: @task.description } }
    end

    it "returns https found" do
      expect(response).to have_http_status(:found)
    end

    it "returns the right params" do
      expect(Task.last.description).to eq (@task.description)
    end

  end

  describe "PATCH #update" do
    before do
      @task = FactoryGirl.create(:task)
      patch :update, params: {id: @task.id, task: { description: "Updated task" } }
      @task.reload
    end

    it 'updates a task' do
      expect(@task.description).to eq("Updated task")
    end
  end

  describe "PATCH #complete" do
    it 'completes a task' do
      @task = FactoryGirl.create(:task, completed_at: nil)
      patch :complete, params: { id: @task.id }
      @task.reload
      expect(@task.completed?).to be true
    end

    it 'marks a task as no completed' do
      @task = FactoryGirl.create(:task)
      patch :complete, params: { id: @task.id }
      @task.reload
      expect(@task.completed?).to be false
    end
  end
end
