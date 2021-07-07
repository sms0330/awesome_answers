class Question < ApplicationRecord
    #This file was generated with: rails g model question
    #A model Question has been created, which is a respresentation of an instance of a Question
    #Models are always singular, at it is convention to capitalize the name
    
    #Also, a corresponding migration file was generated when generating the model
    #To add properties to an instance of Question you can add it to the terminal or
    #add it to the migration file: rails g model question title:string body:text
    #To run the migration, do: rails db:migrate
    #Never make changes to the migration file after migrating it
    #Instead, run: rails db:rollback
    #OR create a new migration to make changes to the existing table

    #---------------------CALLBACKS----------------------------------->
    after_initialize :set_defaults
    before_save :capitalize_title

    #--------------------VALIDATIONS------------------------------------>

    validates :title, presence: {message: "title must be provided"}
    # validates :title, uniqueness: true

    #Below means that the title must be unique for a question in relation to its body
    #i.e. a question can have a title that is the same as another question in the db,
    #but not if it's a duplicate with the same body content
    validates :title, uniqueness: {scope: :body}

    validates :body, length: { minimum: 5, maximum: 500}

    validates :view_count, numericality: {greater_than_or_equal_to: 0}

    #---------------CUSTOM NO-MONKEYS VALIDATION-------------------------->
    validate :no_monkey #we use the "validate instead of "validates" for custom validations

    scope :recent_ten, lambda { order("created_at DESC").limit(10) }
    
    def self.search(arg)
        where("title ILIKE ?", "%#{arg}%" )
        where("body ILIKE ?", "%#{arg}%" )
    end
    
    private

    def no_monkey
        if body&.downcase&.include?("monkey")
            self.errors.add(:body, "Must not have monkey")
        end
    end

    def set_defaults
        self.view_count ||= 0
    end

    def capitalize_title
        self.title.capitalize!
    end

    # def self.recent_ten
    #     order("created_at DESC")
    #     limit(10)
    # end


end