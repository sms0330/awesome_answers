# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#To run this file use command: rails db:seed
Answer.destroy_all
Question.destroy_all

## Diff b/w delete_all and destroy_all
# delete_all will forceably remove records from the corresponding table without activating any rails callbacks.

# destroy_all will remove the records but also call the model callbacks

200.times do
    created_at = Faker::Date.backward(days:365 * 5)
        q = Question.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        view_count: rand(100_000),
        created_at: created_at,
        updated_at: created_at
        )

        if q.persisted? #we can also use .valid? to check if data is entered in db was valid or not
            q.answers = rand(0..15).times.map do
                Answer.new(body: Faker::GreekPhilosophers.quote)
            end
        end
end

questions = Question.all
answers = Answer.all

puts Cowsay.say("Generated #{questions.count} questions", :frogs)
puts Cowsay.say("Generated #{answers.count} answers", :koala)

