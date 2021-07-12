class AddUserToReferenceToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user, foreign_key: true #removed null: false
  end
end