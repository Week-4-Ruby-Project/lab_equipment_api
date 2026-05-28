class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy

  validates :name, presence: true
  validates :serial_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[available in_use under_maintenance retired] }
end
