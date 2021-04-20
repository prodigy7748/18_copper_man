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
    scenario 'with title and content' do
      expect{ create_task(title: title, content: content) }.to change { Task.count }.by(1)
      expect(page).to have_content('新增任務成功！')
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    scenario 'without title and content' do
      create_task()
      expect(page).to have_content('Title can\'t be blank')
      expect(page).to have_content('Content can\'t be blank')
    end

    scenario 'without title' do
      create_task(content: content)
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario 'without content' do
      create_task(title: title)
      expect(page).to have_content('Content can\'t be blank')
    end
  end

  def create_task(title: nil, content: nil)
    visit new_task_path
    fill_in '任務名稱', with: title
    fill_in '內容', with: content
    click_button '新增任務'
  end
end
