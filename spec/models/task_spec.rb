require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "Validations" do
    it "requires a title" do
      t = Task.new
      t.valid?
      expect(t.errors).to have_key(:title)
    end
  end

  describe "Associations" do
    it "belongs to a sprint" do
      expect(Task.reflect_on_association(:sprint).macro).to eq(:belongs_to)
    end

    it "belongs to a node" do
      expect(Task.reflect_on_association(:node).macro).to eq(:belongs_to)
    end

    it "has many children" do
      expect(Task.reflect_on_association(:children).macro).to eq(:has_many)
    end

    it "has many users" do
      expect(Task.reflect_on_association(:users).macro).to eq(:has_many)
    end

    it "has_many task_assignments" do
      expect(Task.reflect_on_association(:task_assignments).macro).to eq(:has_many)
    end
  end
end
