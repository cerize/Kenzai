require 'rails_helper'

RSpec.describe MyProjectsController, type: :controller do

  let(:user)    { FactoryGirl.create(:user) }
  let(:p1)    { FactoryGirl.create(:project) }
  let(:p2)    { FactoryGirl.create(:project) }
  let(:p3)    { FactoryGirl.create(:project) }

  describe "#index" do
    before { signin(user) }

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "it fetches all user's projects and assigns them to @projects in created_at: desc order" do
      user.projects << p1
      user.projects << p2
      get :index
      expect(assigns(:projects)).to eq([p2, p1])
    end

  end

end
