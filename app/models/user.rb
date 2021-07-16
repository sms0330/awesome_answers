class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    has_many :job_posts, dependent: :nullify

    has_secure_password
    # What it needs
    # has_secure_password need password digest column in the database user table 
    # has_secured_password needs gem bcrypt

    # What it provides
    # validation: it will automatically add presence validation for the password field
    # Cross verify each other 'password' and 'password confirmation', so it will add 2 attribute accessors for the 'password' and password_confirmation
    # it is an optional but if we have this, has_secure_password will perform validation on it for us.
    # Once the password is validated and verified,it saves the password in an ecrypted form using brypt and stores in a db , in password_digest column for us
    # it will add a 'authenticate' method to verify user's password. if called with the correct password, it will return 'true' or 'false' based on if the password is correct or not

    def full_name
        "#{first_name} #{last_name}"
    end
end