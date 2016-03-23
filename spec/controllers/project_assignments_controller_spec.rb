require 'rails_helper'

RSpec.describe ProjectAssignmentsController, type: :controller do

  describe "#create" do
    context "with valid attributes" do
      def send_valid_request
        post :create, project_assignment: FactoryGirl.attributes_for(:project_assignment)
      end
      it "creates a record in the database" do

      end
      it "creates a record with a default value of false for is_manager" do
        # pa = FactoryGirl.create()
        # pa.is_manager = nil
        # pa.valid?
        # expect(pa.errors).to have_key(:is_manager)
      end

    end
    context "with invalid attributes" do

    end


  end

  describe "destroy" do

  end

end
