require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let(:title) { Faker::Lorem.sentence }
  let(:content) { Faker::Lorem.paragraph }
  let(:task) { create(:task, title: title, content: content) }

  describe 'visit task index page' do
    it 'should show all tasks' do
      3.times { create(:task) }
      expect(Task.count).to eq(3)
      visit tasks_path

      titles = all('#task_index_table tr > td:first-child').map(&:text)
      result = Task.pluck(:title)
      expect(titles).to eq result
    end
  end

  describe 'creates a new task' do
    before do 
      visit new_task_path
    end

    scenario 'with title and content' do
      fill_in 'Title', with: title
      fill_in 'Content', with: content
      click_button 'Create Task'
      expect { create(:task) }.to change { Task.count }.by(1)
      expect(page).to have_content('新增任務成功！')
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    scenario 'without title and content' do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''
      click_button 'Create Task'
      expect(page).to have_content('Title can\'t be blank')
      expect(page).to have_content('Content can\'t be blank')
    end

    scenario 'without title' do
      fill_in 'Title', with: ''
      click_button 'Create Task'
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario 'without content' do
      fill_in 'Content', with: ''
      click_button 'Create Task'
      expect(page).to have_content('Content can\'t be blank')
    end
  end
end
