require "rails_helper"

RSpec.describe RobotsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    it "convert currency and send to twitter" do
      expect(TweetForm.new({ "currency_id": 1}).create).to eq true
    end
  end
end