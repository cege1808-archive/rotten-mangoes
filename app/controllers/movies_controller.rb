class MoviesController < ApplicationController

  def index
    if params[:title_query] || params[:director_query] 

      # transform from "0,89" to [0,89]
      # TODO suggestion, use case 1,2,3,4 and make a private method to identify which correspond to which
      params[:runtime_in_minutes_query] = params[:runtime_in_minutes_query].split(",").map(&:to_i)

      @movies = Movie.title_search(params[:title_query]).director_search(params[:director_query]).runtime_in_minutes_search(params[:runtime_in_minutes_query])
    else
      @movies = Movie.order(release_date: :desc)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create 
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit
    end
  end

  def destroy 
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected 

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :remote_image_url, :description)
  end
  
end
