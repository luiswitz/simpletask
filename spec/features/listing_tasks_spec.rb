require 'rails_helper'

RSpec.describe "listing tasks", :type => :feature do
  
  before do
    @task1 = FactoryGirl.create(:task)
    @task2 = FactoryGirl.create(:task)

    visit root_path
  end

  it 'should list two tasks' do
    expect(page).to have_content(@task1.description)
    expect(page).to have_content(@task2.description)
  end
end