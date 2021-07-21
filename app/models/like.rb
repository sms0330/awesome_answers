class Like < ApplicationRecord
    belongs_to :question
    belongs_to :user

    #The  below validation is saying that once a particular question is liked by a user, no other likes can be created for that particular question
    # validates :question_id, uniqueness: true

    validates(
        :question_id,
        uniqueness: {
            scope: :user_id,
            message: "has already been liked"
        }
    )
end