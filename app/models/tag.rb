class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :questions, through: :taggings

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    #The case_sensitive option will make uniqueness validation ignore case. i.e. two records of "Science" and "SCIENCE" can't co-exist
end