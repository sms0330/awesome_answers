class AddUserToReferenceToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user, foreign_key: true #removed null: false
  end
end
