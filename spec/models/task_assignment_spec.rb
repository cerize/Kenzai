require 'rails_helper'

RSpec.describe TaskAssignment, type: :model do

  describe "Associations" do
    it "belongs to a user" do
      expect(TaskAssignment.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      expect(TaskAssignment.reflect_on_association(:task).macro).to eq(:belongs_to)
    end
  end
end
