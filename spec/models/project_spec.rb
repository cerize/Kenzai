
require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "Validations" do
    it "requires a title" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a start_date" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:start_date)
    end

    it "requires an end_date" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:end_date)
    end
  end

  describe "Associations" do
    it "belongs_to creator" do
      expect(Project.reflect_on_association(:creator).macro).to eq(:belongs_to)
    end

    it "has many :sprints" do
      expect(Project.reflect_on_association(:sprints).macro).to eq(:has_many)
    end

    it "has many :snippets" do
      expect(Project.reflect_on_association(:snippets).macro).to eq(:has_many)
    end

    it "has many :mudas" do
      expect(Project.reflect_on_association(:mudas).macro).to eq(:has_many)
    end

    it "has many :members" do
      expect(Project.reflect_on_association(:members).macro).to eq(:has_many)
    end

    it "has many :project_assignments" do
      expect(Project.reflect_on_association(:project_assignments).macro).to eq(:has_many)
    end
  end

end
