FactoryBot.define do
  RANDOM_HUNDRED_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello hello worl hello world hello world"
  factory :job_post do
    sequence(:title) {|n| Faker::Job.title + " #{n}"} #sequence is a method provided by factory-bot which accepts a lambda injecting a variable n. n is usually a number that factory-bot increments on every object it generates so we can use it to make sure all instances created are unique
    description { Faker::Job.field + "-#{RANDOM_HUNDRED_CHARS}"}
    company_name { Faker::Company.name}
    min_salary { rand( 80_000..200_000)}
    max_salary { rand(200_000..400_000)}
    location{ Faker::Address.city}
    association(:user, factory: :user)
  end

  #FactoryBot.create(:job_post) #Will create the object and save it to the db
  #FactoryBot.build(:job_post) #Will create the object like .new but not save it to the db
  #FactoryBot.attributes_for(:job_post) #Will generate only attributes for job_post
end