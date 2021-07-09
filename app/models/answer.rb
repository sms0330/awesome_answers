class Answer < ApplicationRecord
  #GENERATING THIS FILE:
  #rails g model answer body:text question:references

  #-----------------------------Associations--------------------------------->
  belongs_to :question
  #Above is similar to: validates :question_id, presence: true
  #If youb want to disable this constraint, you can add "optional: true" to the belongs_to method
  # Primary Key: Any id / integer refering to the column in its own table is known as primary key
  # Foreign Key: Any id that refers to the other table is known as foreign key 
  #--------------------------------------------------------------------------->

  #----------------------------Validations------------------------------------>
  validates :body, length: { minimum: 5, maximum: 500}
end