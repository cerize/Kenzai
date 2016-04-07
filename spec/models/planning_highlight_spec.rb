require 'rails_helper'

RSpec.describe PlanningHighlight, type: :model do

  describe "Validations" do
    it "requires a description" do
      p = PlanningHighlight.new
      p.valid?
      expect(p.errors).to have_key(:description)
    end
  end

  describe "Associations" do
    it "belongs to a sprint" do
      expect(PlanningHighlight.reflect_on_association(:sprint).macro).to eq(:belongs_to)
    end
  end

end
