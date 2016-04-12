class RobotsController < ApplicationController
  def index
    @currencies = Currency.all
    @tweet_form = TweetForm.new
  end

  def create
    @tweet_form = TweetForm.new(tweet_params).create
  end

  private
  def tweet_params
    params.require(:tweet_form).permit(:currency_id)
  end
end

