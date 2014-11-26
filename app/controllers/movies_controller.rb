class MoviesController < ApplicationController
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:notice] = "New movie added!"
      redirect_to root_path
    else
      flash[:error] = @movie.errors.full_messages
      @movies = Movie.all
      render 'robots/index'
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    flash[:notice] = "Movie #{movie.title} removed"
    redirect_to root_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title)
  end
end
