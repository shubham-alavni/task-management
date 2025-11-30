class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validate :due_date_cannot_be_in_the_past

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }

  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end
end
