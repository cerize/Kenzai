
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

end
