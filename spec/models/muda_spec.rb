require 'rails_helper'

RSpec.describe Muda, type: :model do

  describe "Validations" do
    it "requires a title" do
      m = Muda.new
      m.valid?
      expect(m.errors).to have_key(:title)
    end

    it "requires a description" do
      s = Muda.new
      s.valid?
      expect(s.errors).to have_key(:description)
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      expect(Muda.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to a project" do
      expect(Muda.reflect_on_association(:project).macro).to eq(:belongs_to)
    end
  end

end
