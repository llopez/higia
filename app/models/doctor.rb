class Doctor < User
  validates :license_number, presence: true
  has_many :appointments
end
