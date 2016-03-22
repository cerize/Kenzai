require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    before {get :new}

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "instantiates a user object and sets it to @user instance" do
      expect(assigns(:user)).to be_a_new(User)
    end

  end

  describe "#create" do
    context "successful create" do
      def send_valid_request
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      before { send_valid_request }

      it "creates a user record in the database" do
        expect{send_valid_request}.to change{User.count}.by(1)
      end

      it "sets the session user_id to the created user" do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to the user's projects page" do
        expect(response).to redirect_to(my_projects_path)
      end

      it "sets a flash notice message" do
        expect(flash[:notice]).to be
      end

    end

    context "unsuccessful create" do
      def send_invalid_request
        post :create, user: FactoryGirl.attributes_for(:user, {email: nil})
      end

      before { send_invalid_request }

      it "doesn't create a user record in the database" do
        expect{send_invalid_request}.to_not change{User.count}
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        expect(flash[:alert]).to be
      end
    end
  end
end
