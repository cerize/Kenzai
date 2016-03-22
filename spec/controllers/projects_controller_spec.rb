require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user)    { FactoryGirl.create(:user) }
  let(:user2)   { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, {creator: user}) }

  describe 'with user signed in' do
    before { signin(user) }

    describe "#new" do

      before { get :new }

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it "instantiates a new Project object and sets it to @project" do
        expect(assigns(:project)).to be_a_new(Project)
      end


    end

    ##################create#########################

    describe "#create" do

      context "with valid attributes" do
        def send_valid_request
          post :create, project: FactoryGirl.attributes_for(:project)
        end

        it "creates a record in the database" do
          expect{send_valid_request}.to change{Project.count}.by(1)
        end

        it "redirects to the project show page" do
          send_valid_request
          expect(response).to redirect_to(project_path(Project.last))
        end

        it "sets a flash notice message" do
          send_valid_request
          expect(flash[:notice]).to be
        end

        it "sets current user as the project creator" do
          send_valid_request
          expect(Project.last.creator).to eq(user)
        end

      end
      context "with invalid attributes" do
        def send_invalid_request
          post :create, project: FactoryGirl.attributes_for(:project, title: nil)
        end

        it "doesn't create a record in the database" do
          expect{send_invalid_request}.to_not change{Project.count}
        end

        it "renders the new template" do
          send_invalid_request
          expect(response).to render_template(:new)
        end

        it "sets a flash alert message" do
          send_invalid_request
          expect(flash[:alert]).to be
        end
      end
    end

    ##################show#########################


    describe "#show" do
      context "current user is a member of the project" do
        before do
          post :create, project: FactoryGirl.attributes_for(:project, creator: user)
          get :show, id: Project.last.id
        end


        it "finds the object by its id and sets to @project variable" do
          expect(assigns(:project)).to eq(Project.last)
        end

        it "renders the show template" do
          #expect(response).to render_template(:show)
        end

      end

      context "current user is NOT a member of the project" do
        it "redirects to root path" do
          signin(user2)
          get :show, id: project.id
          expect(response).to redirect_to(root_path)
        end
      end

    end


    ##################edit#########################

    describe "#edit" do
      before do
        # get :edit, id: campaign
      end

      it "renders the edit template" do
      end

      it "finds the campaign by id and sets it to @campaign instance variable" do
      end
    end

    ##################update#########################
    describe "#update" do
      context "with valid attributes" do
        before do
          # patch :update, id: campaign.id, campaign: {name: "new valid name"}
        end

        it "updates the records with new parameter(s)" do
        end

        it "redirects to the campaign show page" do
        end

        it "sets a flash notice message" do
        end
      end
      context "with invalid attributes" do
        it "doesn't update the record" do
        end

        it "renders the edit template" do
        end

        it "sets a flash alert message" do
        end
      end
    end

    ##################destroy#########################

    describe "#destroy" do
      context "with no user signed in" do
        it "redirects to the sign in page" do
        end
      end

      context "with user signed in" do
        # before { signin(user) }
        context "with user owning the campaign" do
          it "removes the campaign from the database" do
          end

          it "redirects to the campaign index page" do
          end

          it "Sets a flash message" do
          end
        end

        context "with user that doesn't own the campaign" do
          it "raises an error" do
          end
        end
      end
    end
  end


  describe 'with not user signed in' do

    it "redirect_to sign in page when trying to access new project page" do
      get :new
      expect(response).to redirect_to(new_session_path)
    end

    it "redirects to sign in page when try to create a project" do
      post :create, project: FactoryGirl.attributes_for(:project)
      expect(response).to redirect_to(new_session_path)
    end

  end








end
