class Movie < ApplicationRecord
  has_and_belongs_to_many :actors

  validates :title, presence: true
  validates :year, presence: true,
            inclusion: { in: 1900..Date.today.year+5 },
            format: {
                with: /(19|20)\d{2}/i,
                message: "Should be a correct year"
            }
end
