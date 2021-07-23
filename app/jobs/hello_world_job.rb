class HelloWorldJob < ApplicationJob
  #Docs: https://guides.rubyonrails.org/active_job_basics.html

  #To generate the migration for delayed_job's queue, run:
  #rails g delayed_job:active_record

  #To generate a job file:
  # rails g job <job-name>
  
  queue_as :default

  #When a job is executed, the "perform" method will be called
  def perform(*args)
    # Do something later
    puts "----------------------------"
    puts "Running a job... 🏃‍♀️"
    puts "----------------------------"
  end
end