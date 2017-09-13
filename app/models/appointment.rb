class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient, optional: true
  validates :date, presence: true
end
