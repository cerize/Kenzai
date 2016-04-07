require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "requires a first name" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end

    it "requires a last name" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end

    it "requires an email" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:email)
    end

    it "requires a unique email" do
      u1 = FactoryGirl.create(:user)
      u2 = User.new(email: u1.email)
      u2.valid?
      expect(u2.errors).to have_key(:email)
    end

    it "has an email in the right format" do
      u = User.new
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        u.email = invalid_address
        u.valid?
        expect(u.errors).to have_key(:email)
      end
    end

    it "requires a password" do
      u = User.new
      u.valid?
      expect(u.errors).to have_key(:password)
    end

    it "requires a password at least 6 characters long" do
      u = User.new password: "12345"
      u.valid?
      expect(u.errors).to have_key(:password)
    end

  end

  describe "Associations" do
    it "has many :project_assignments" do
      expect(User.reflect_on_association(:project_assignments).macro).to eq(:has_many)
    end

    it "has many :projects" do
      expect(User.reflect_on_association(:projects).macro).to eq(:has_many)
    end

    it "has many :task_assignments" do
      expect(User.reflect_on_association(:task_assignments).macro).to eq(:has_many)
    end

    it "has many :tasks" do
      expect(User.reflect_on_association(:tasks).macro).to eq(:has_many)
    end

    it "has many :created_projects" do
      expect(User.reflect_on_association(:created_projects).macro).to eq(:has_many)
    end

    it "has many :snippets" do
      expect(User.reflect_on_association(:snippets).macro).to eq(:has_many)
    end

    it "has many mudas" do
      expect(User.reflect_on_association(:mudas).macro).to eq(:has_many)
    end
    
    it "has many comments" do
      expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
    end
  end

    describe ".full_name" do
      it "concatenates the first name and last name" do
        u = FactoryGirl.build(:user)
        expect(u.full_name).to include("#{u.first_name}", "#{u.last_name}")
      end
    end

    describe "password generating" do
      it "generates a password digest on creation" do
        u = FactoryGirl.build(:user)
        # used this to make the test fails
        # u.password_digest = "a" * 58
        # BCrypt generates a password_digest with 59 or 60 characters
        expect(u.password_digest.length).to be > 58
      end
    end
  end
