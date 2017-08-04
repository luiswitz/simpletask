class Task < ApplicationRecord
  validates_presence_of :description

  def completed?
    !!completed_at
  end
end
