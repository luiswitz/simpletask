require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryGirl.build(:task)
  end
  it 'should not be valid without a description' do
    @task.description = ''
    expect(@task).to_not be_valid
  end

  it 'should be completed' do
    expect(@task.completed?).to be true
  end
end
