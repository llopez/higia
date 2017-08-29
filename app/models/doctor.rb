class Doctor < User
  validates :license_number, presence: true
end
