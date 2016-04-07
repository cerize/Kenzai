require 'rails_helper'

RSpec.describe Sprint, type: :model do
  let(:project)  { FactoryGirl.create(:project) }
  let(:project2) { FactoryGirl.create(:project) }
  let(:s1)       { FactoryGirl.create(:sprint, {project: project}) }

  describe "Validations" do

    it "requires a title" do
      s = Sprint.new
      s.valid?
      expect(s.errors).to have_key(:title)
    end

    it "requires a start date" do
      s = Sprint.new
      s.valid?
      expect(s.errors).to have_key(:start_date)
    end

    it "requires an end date" do
      s = Sprint.new
      s.valid?
      expect(s.errors).to have_key(:end_date)
    end

    it "requires a unique title for the same project" do
      s2 = Sprint.new(title: s1.title)
      s2.project = s1.project
      s2.valid?
      expect(s2.errors).to have_key(:title)
    end

    it "does not requires a unique title for different projects" do
      s2 = Sprint.new(title: s1.title)
      s2.project = project2
      s2.valid?
      expect(s2.errors).not_to have_key(:title)
    end

  end

  describe "Associations" do

    it "belongs_to project" do
      expect(Sprint.reflect_on_association(:project).macro).to eq(:belongs_to)
    end

    it "has many :user_stories" do
      expect(Sprint.reflect_on_association(:user_stories).macro).to eq(:has_many)
    end

    it "has many :tasks" do
      expect(Sprint.reflect_on_association(:tasks).macro).to eq(:has_many)
    end

    it "has many :comments" do
      expect(Sprint.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it "has many :planning_highlights" do
      expect(Sprint.reflect_on_association(:planning_highlights).macro).to eq(:has_many)
    end

    it "has many :review_highlights" do
      expect(Sprint.reflect_on_association(:review_highlights).macro).to eq(:has_many)
    end
  end





end
