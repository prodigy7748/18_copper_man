require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let(:title) { Faker::Lorem.sentence }
  let(:content) { Faker::Lorem.paragraph }
  let(:start_time) { Faker::Time.between(from: DateTime.now - 3.day ,to: DateTime.now - 2.day) }
  let(:end_time) { Faker::Time.between(from: DateTime.now - 1.day, to: DateTime.now) }
  let(:task) { create(:task, title: title, content: content, start_time: start_time, end_time: end_time) }

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
      expect{ create_task(title: title, content: content, start_time: start_time, end_time: end_time) }.to change { Task.count }.by(1)
      expect(page).to have_content(I18n.t('tasks.create.notice'))
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    scenario 'without title and content' do
      create_task()
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.content')} #{I18n.t('activerecord.errors.models.task.attributes.content.blank')}")
    end

    scenario 'without title' do
      create_task(content: content)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    scenario 'without content' do
      create_task(title: title)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.content')} #{I18n.t('activerecord.errors.models.task.attributes.content.blank')}")
    end
  end

  describe 'update tasks' do
    let(:new_title) { Faker::Lorem.sentence }
    let(:new_content) { Faker::Lorem.paragraph }

    scenario 'with new_title and new_content' do
      update_task(title: new_title, content: new_content)
      expect(page).to have_content(I18n.t('tasks.edit.notice'))
      expect(page).to have_content(new_title)
      expect(page).to have_content(new_content)
    end

    scenario 'without title and content' do
      update_task()
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.content')} #{I18n.t('activerecord.errors.models.task.attributes.content.blank')}")
    end

    scenario 'without title' do
      update_task(content: new_content)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    scenario 'without content' do
      update_task(title: new_title)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.content')} #{I18n.t('activerecord.errors.models.task.attributes.content.blank')}")
    end
  end

  describe 'show a task' do
    it 'should show right content of a task' do
      visit task_path(task)
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end
  end

  describe 'delete tasks' do
    it do
      delete_task
      expect(Task.count).to eq(0)
      expect(page).to have_content(I18n.t('tasks.destroy.notice'))
    end
  end

  describe 'sort by columns' do
    before do
      1.upto(3) do |i|
        Task.create(title: "title #{i}", content: "content #{i}", start_time: "2021/Apr/0#{i} 10:30:00", end_time: "2021/Apr/2#{i} 18:35:00")
      end
      visit tasks_path
    end

    it 'order by created_at asc' do
      expect(page).to have_content(
        /title 1.*title 2.*title 3/
      )
    end

    it 'order by created_at desc' do
      click_on I18n.t("tasks.table.created_at")
      expect(page).to have_content(
        /title 3.*title 2.*title 1/
      )
    end

    it 'order by end_time asc' do
      expect(page).to have_content(
        /title 1.*title 2.*title 3/
      )
    end

    it 'order by end_time desc' do
      click_on I18n.t("tasks.table.end_time")
      expect(page).to have_content(
        /title 3.*title 2.*title 1/
      )
    end
  end

  def create_task(title: nil, content: nil, start_time: nil, end_time: nil)
    visit new_task_path
    fill_in I18n.t("tasks.table.title"), with: title
    fill_in I18n.t("tasks.table.content"), with: content
    fill_in I18n.t("tasks.table.start_time"), with: start_time
    fill_in I18n.t("tasks.table.end_time"), with: end_time
    find('input[name="commit"]').click
  end

  def update_task(title: nil, content: nil)
    visit edit_task_path(task)
    fill_in I18n.t("tasks.table.title"), with: title
    fill_in I18n.t("tasks.table.content"), with: content
    find('input[name="commit"]').click
  end

  def delete_task
    create_task(title: title, content: content, start_time: start_time, end_time: end_time)
    visit tasks_path
    click_on I18n.t('tasks.link.delete_task')
  end
end
