require 'rails_helper'

RSpec.describe Snippet, type: :model do

  describe "Validations" do
    it "requires a title" do
      s = Snippet.new
      s.valid?
      expect(s.errors).to have_key(:title)
    end

    it "requires a description" do
      s = Snippet.new
      s.valid?
      expect(s.errors).to have_key(:description)
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      expect(Snippet.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to a project" do
      expect(Snippet.reflect_on_association(:project).macro).to eq(:belongs_to)
    end
  end
end
