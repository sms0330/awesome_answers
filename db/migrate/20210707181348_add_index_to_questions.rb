class AddIndexToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_index :questions, :title
    add_index :questions, :body
  end
end