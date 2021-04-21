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
end
