class HoursOperation < ApplicationRecord
  belongs_to :establishment

  validates :weekday, :opening_time, :closing_time, presence: true
  validates :closed, inclusion: { in: [true, false] }

  enum :weekday, { 
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6
  }

end
