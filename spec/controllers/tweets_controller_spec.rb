require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  before do
    create :tweet_datum
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    context "assigns @tweet" do
      it "is a tweet" do
        get :new
        expect(assigns[:tweet]).to be_a Tweet
      end

      it "is new record" do
        get :new
        expect(assigns[:tweet]).to be_new_record
      end
    end

    context "assigns @unsent" do
      it "is an unsent tweets" do
        t1 = create :tweet
        t2 =  create :tweet
        get :new
        expect(assigns[:unsent]).to include t1
        expect(assigns[:unsent]).to include t2
      end
    end

    context "assigns @unreplied" do
      it "is an unsent tweets" do
        t1 = create :tweet, reply: true
        t2 =  create :tweet, reply: true
        get :new
        expect(assigns[:unreplied]).to include t1
        expect(assigns[:unreplied]).to include t2
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
