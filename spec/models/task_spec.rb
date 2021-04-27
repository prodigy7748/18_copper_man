require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:subject) { create(:task) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:priority) }
    it { should define_enum_for(:priority).with_values(%w(low medium high)) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(%w(pending processing completed)) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end

  describe 'filter' do
    let(:content) { Faker::Lorem.paragraph }
    let(:start_time) { Faker::Time.between(from: DateTime.now - 3.day ,to: DateTime.now - 2.day) }
    let(:end_time) { Faker::Time.between(from: DateTime.now - 1.day, to: DateTime.now) }

    before :each do
      create(:task, title:'aaa123', content: content, start_time: start_time, end_time: end_time, status: "pending")
      create(:task, title:'ddd123', content: content, start_time: start_time, end_time: end_time, status: "processing")
      create(:task, title:'ccc456', content: content, start_time: start_time, end_time: end_time, status: "pending")
    end
    it 'by title' do
      tasks = Task.filter_by_title('123')
      expect(tasks.count).to eq(2)
    end

    it 'by status' do
      tasks = Task.filter_by_status('pending')
      expect(tasks.count).to eq(2)
    end
  end
end
