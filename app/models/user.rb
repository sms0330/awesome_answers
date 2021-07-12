class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify

    has_secure_password
    #in-built method in rails used when performing user authentication
    #provides user authentication feature on the model that it is called in
    #the above requires a password_digest as a column in the database and a gem knows as bcrypt
    #it will add a presence validation for the password field; don't need to add validation manually

    #sign_up
    #it cross verities teh passwor with the password confirmation text field

    #sign_in
    #using the equal to operator to confirm -> not that simple
    #our password is encrypted and saved in db, so this creates a authenticate method to verify user/pwd with the database

    def full_name
        "#{first_name} #{last_name}"
    end
end