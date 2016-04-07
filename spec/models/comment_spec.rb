require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "Validations" do
    it "requires a description" do
      c = Comment.new
      c.valid?
      expect(c.errors).to have_key(:description)
    end
  end

  describe "Associations" do
    it "belongs to a sprint" do
      expect(Comment.reflect_on_association(:sprint).macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
