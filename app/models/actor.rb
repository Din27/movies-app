class Actor < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, presence: true
  validates :dob, presence: true
end
