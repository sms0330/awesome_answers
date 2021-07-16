class JobPost < ApplicationRecord
    #Associations
    belongs_to :user

    #Validations
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true, length: {minimum: 100}
    validates :min_salary, numericality: { greater_than_or_equal_to: 30_000}
    validates :location, presence: true
end