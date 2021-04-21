class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :sorted_by, ->(sort_option) {
    direction = /desc$/.match?(sort_option) ? "desc" : "asc"
    case sort_option.to_s
    when /^created_at_/
      order("created_at #{direction}")
    end
  }
end
