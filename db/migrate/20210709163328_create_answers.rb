class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, null: false, foreign_key: true

      #The above creates a "question_id" column
      #of type 'big_int'.  It also sets a foreign key
      #constraint to enforce the association to the questions table
      #at the database level.  The question_id will refer to the id
      # of the question in the questions table.  It is said that the
      #answer "belongs to" the question.

      #As of Rails 5, this will also add an index to the foreign key field
      #(in this case question_id). If you don't want an index you can pass the option:
      #index: false

      #Big int can go from -9_223_372_036_854_775_807 to 9_223_372_036_854_775_807

      #Int -2_147_483_648 to 2_147_483_648

      t.timestamps
    end
  end
end