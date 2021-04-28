class Task < ApplicationRecord
  include Filterable
  paginates_per 5

  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { pending: 0, processing: 1, completed: 2 }

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :priority, presence: true, inclusion: { in: %w(low medium high) }
  validates :status, presence: true, inclusion: { in: %w(pending processing completed) }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_cannot_greater_than_end_time

  scope :sorted_by, ->(sort_option) {
    direction = /desc$/.match?(sort_option) ? "desc" : "asc"
    case sort_option.to_s
    when /^created_at_/
      order("created_at #{direction}")
    when /^end_time_/
      order("end_time #{direction}")
    when /^priority_/
      order("priority #{direction}")
    end
  }

  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_title, -> (title) { where("lower(title) LIKE ?", "%#{title}%") }

  private
    def start_time_cannot_greater_than_end_time
      if !start_time.nil? && !end_time.nil?
        if start_time > end_time
          errors.add(:start_time, I18n.t('tasks.start_time_cannot_greater_than_end_time'))
        end
      end
    end
end
