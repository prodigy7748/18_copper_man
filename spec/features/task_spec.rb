require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let(:title) { Faker::Lorem.sentence }
  let(:content) { Faker::Lorem.paragraph }
  let(:task) { create(:task, title: title, content: content) }

  describe 'user visit task index page' do
    it 'should show all tasks' do
      3.times { create(:task) }
      visit tasks_path

      titles = all('#task_index_table tr > td:first-child').map(&:text)
      result = Task.pluck(:title)
      expect(titles).to eq result
    end
  end
end
