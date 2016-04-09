class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params.require(:tweets).permit(:content))
    if @tweet.save
      redirect_to root_path, notice: 'Tweet submitted'
    else
      flash.now[:warning] = 'Tweet submission failed'
      render :new
    end
  end
end
