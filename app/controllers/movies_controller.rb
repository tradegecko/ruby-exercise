class MoviesController < ApplicationController
  def create
    @movie = Movie.find_or_create_by(movie_params)
    @movie.update(state: 'active')

    if @movie.persisted?
      Sentwix::Engine.analyze(@movie)
      flash[:notice] = "Movie is in the list."
      redirect_to root_path
    else
      flash[:error] = @movie.errors.full_messages
      @movies = Movie.all
      @tweets = Tweet.all
      render 'robots/index'
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.update(state: 'inactive')
    flash[:notice] = "Movie #{movie.title} removed"
    redirect_to root_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :image_url)
  end
end
