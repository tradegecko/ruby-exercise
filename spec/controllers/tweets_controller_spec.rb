require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    context "assigns" do
      it "is a tweet" do
        get :new
        expect(assigns[:tweet]).to be_a Tweet
      end

      it "is new record" do
        get :new
        expect(assigns[:tweet]).to be_new_record
      end
    end
  end

  describe "POST #create" do
    context "if invalid" do
      before do
        post :create, tweet: { content: '' }
      end
      it "should render #new" do
        expect(response).to render_template 'tweets/new'
      end

      it "should have correct flash" do
        expect(flash.now[:warning]).to eql 'Tweet submission failed'
      end
    end

    context "if valid" do
      it "should create new tweet" do
        expect{
          post :create, tweet: { content: 'New content' }
        }.to change(Tweet, :count).by 1
      end

      it "should have correct redirect" do
        post :create, tweet: { content: 'New content' }
        expect(response).to redirect_to root_path
      end

      it "should have correct flash" do
        post :create, tweet: { content: 'New content' }
        expect(flash[:success]).to eql 'Tweet submitted'
      end
    end
  end
end
