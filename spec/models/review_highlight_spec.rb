require 'rails_helper'

RSpec.describe ReviewHighlight, type: :model do

  describe "Validations" do
    it "requires a description" do
      r = ReviewHighlight.new
      r.valid?
      expect(r.errors).to have_key(:description)
    end
  end
  
  describe "Associations" do
    it "belongs to a sprint" do
      expect(ReviewHighlight.reflect_on_association(:sprint).macro).to eq(:belongs_to)
    end
  end

end
