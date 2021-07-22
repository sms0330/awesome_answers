# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#To run this file use command: rails db:seed
Like.destroy_all
Tagging.destroy_all
Tag.destroy_all
User.destroy_all
Answer.destroy_all
Question.destroy_all
JobPost.destroy_all

## Diff b/w delete_all and destroy_all
# delete_all will forceably remove records from the corresponding table without activating any rails callbacks.

# destroy_all will remove the records but also call the model callbacks
PASSWORD='supersecret'
super_user=User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
)

10.times do
    first_name=Faker::Name.first_name
    last_name=Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: PASSWORD
    )
end
users=User.all

NUM_TAGS = 20

NUM_TAGS.times do
    Tag.create(
        name: Faker::Vehicle.make
    )
end

tags = Tag.all

200.times do
    created_at = Faker::Date.backward(days:365 * 5)
        q = Question.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        view_count: rand(100_000),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
        )

        if q.persisted? #we can also use .valid? to check if data is entered in db was valid or not
            q.answers = rand(0..15).times.map do
                Answer.new(body: Faker::GreekPhilosophers.quote, user: users.sample)
            end
        end
        q.likers = users.shuffle.slice(0, rand(users.count))
        q.tags = tags.shuffle.slice(0, rand(tags.count))
end

RANDOM_HUNDRED_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello hello worl hello world hello world"
10.times do  
jb = JobPost.create(
    title:  Faker::Job.title, 
    description:  Faker::Job.field + "-#{RANDOM_HUNDRED_CHARS}",
    company_name:  Faker::Company.name,
    min_salary:  rand( 80_000..200_000),
    max_salary:  rand(200_000..400_000),
    location: Faker::Address.city,
    user: users.sample
)

end

questions = Question.all
answers = Answer.all

puts Cowsay.say("Generated #{questions.count} questions", :cow)
puts Cowsay.say("Generated #{answers.count} answers", :tux)
puts Cowsay.say("Generated #{users.count} users", :beavis)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :koala)
puts Cowsay.say("Generated #{Like.count} likes", :frogs)
puts Cowsay.say("Generated #{Tag.count} tags", :bunny)

