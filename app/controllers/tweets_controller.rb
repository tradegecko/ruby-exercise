class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    client.tweet(tweet_params[:text])
    redirect_to new_tweet_url
  end

private
  def tweet_params
    params.require(:tweet).permit(:text)
  end

  def client
    @client ||= TwitterAdapter.new
  end
end
