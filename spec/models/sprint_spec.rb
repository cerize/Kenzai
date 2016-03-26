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





end
