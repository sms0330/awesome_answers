class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true} #develop db constraint; a user is represented by a unique email address; index come in handy when searching in our db by this field
      t.string :password_digest

      t.timestamps
    end
  end
end