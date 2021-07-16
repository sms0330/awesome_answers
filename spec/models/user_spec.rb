require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#full_name" do
    it "joins first_name & last_name together with a spec" do
      user = FactoryBot.build(:user, first_name: "Jane", last_name: "Doe")
      expect(user.full_name).to eq("Jane Doe")
    end
  end

  describe "validates" do
    it "requires unique emails" do
      persisted_user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, email: persisted_user.email)
      user.valid?
      expect(user.errors.messages).to(have_key(:email))
    end

    ["what", "$()@something.com", "bob@gglo.88", "test@test#com", "name@domain.g-z"]. each do |invalid_email|
      it "requires an invalid email, like #{invalid_email}'s format/regex to be invalid" do
        user = FactoryBot.build(:user)
        user.email = invalid_email
        user.valid?
        expect(user.errors.messages).to(have_key(:email), "expected #{invalid_email} to be invalid")
      end
    end

  end
end