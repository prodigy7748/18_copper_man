class Task < ApplicationRecord
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { pending: 0, processing: 1, completed: 2 }

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted_by, ->(sort_option) {
    direction = /desc$/.match?(sort_option) ? "asc" : "desc"
    case sort_option.to_s
    when /^created_at_/
      order("created_at #{direction}")
    end
  }
end
