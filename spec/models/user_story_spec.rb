require 'rails_helper'

RSpec.describe UserStory, type: :model do

  describe "Validations" do
    it "requires a title" do
      us = UserStory.new
      us.valid?
      expect(us.errors).to have_key(:title)
    end
  end

  describe "Associations" do
    it "belongs to a sprint" do
      expect(UserStory.reflect_on_association(:sprint).macro).to eq(:belongs_to)
    end
  end

end
