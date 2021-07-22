class Tag < ApplicationRecord
    before_save :downcase_name
    
    has_many :taggings, dependent: :destroy
    has_many :questions, through: :taggings

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    #The case_sensitive option will make uniqueness validation ignore case. i.e. two records of "Science" and "SCIENCE" can't co-exist

    private

    def downcase_name
        self.name&.downcase!
    end
end