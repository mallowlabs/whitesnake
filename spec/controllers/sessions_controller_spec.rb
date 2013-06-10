require 'spec_helper'

describe SessionsController do

  describe "GET 'create'" do
    context 'when the authentication with OmniAuth is succeeded' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        User.stub(:from_omniauth).and_return(user)
      end

      it 'redirects to root' do
        get 'create', provider: 'github'
        response.should redirect_to root_path
      end
    end
  end

  describe "GET 'failure'" do
    it "returns http success" do
      get 'failure'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
