require 'spec_helper'

describe TopController do

  describe "GET 'show'" do
    context 'When a user is logged in' do
      let(:user) { FactoryGirl.create(:user) }

      it 'redirects to users#show' do
        session[:user_id] = user.id
        get 'show'
        response.should redirect_to user_path
      end
    end

    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
