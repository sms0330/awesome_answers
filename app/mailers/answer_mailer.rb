class AnswerMailer < ApplicationMailer
    def hello_world
        mail(
            to: 'stephanie@codecore.ca',
            from: 'anyone@example.com',
            cc: 'someone.else@example.com',
            bcc: 'another.person@example.com',
            subject: 'Hello World'
        )
    end

    def new_answer(answer)
        @answer = answer
        @question = answer.question
        @owner = @question.user
        mail(to: @owner.email, subject: 'You got a new answer!')

    end
end