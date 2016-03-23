require 'rails_helper'

RSpec.describe ProjectAssignment, type: :model do

  let(:user)       { FactoryGirl.create(:user)}
  let(:project)    { FactoryGirl.create(:project)}

  describe "Validations" do

    it "requires a user_id" do
      pa = ProjectAssignment.new
      pa.valid?
      expect(pa.errors).to have_key(:user_id)
    end

    it "requires a project_id" do
      pa = ProjectAssignment.new
      pa.valid?
      expect(pa.errors).to have_key(:project_id)
    end

    it "requires a unique user for a given project" do
      pa = ProjectAssignment.create({project: project, user: user})
      pa2 = ProjectAssignment.new({project: project, user: user})
      pa2.valid?
      expect(pa2.errors).to have_key(:user_id)
    end

  describe ".find_record" do
    it "returns the project_assignment record" do
      pa = ProjectAssignment.create({project: project, user: user})
      expect(ProjectAssignment.find_record(user, project)).to eq(pa)
    end
  end

  describe ".set_as_manager" do
    it "sets the project_assignment record to is_admin = true" do
      puts user.id
      puts project.id
      pa = ProjectAssignment.create({project: project, user: user})
      ProjectAssignment.set_as_manager(user, project)
      pa = ProjectAssignment.find_record(user, project)
      expect(pa.is_manager).to eq(true)
    end
  end

  end





end
