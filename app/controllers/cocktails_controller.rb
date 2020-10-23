require 'json'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
    @images = pixabay_random_pic
  end
  def show
    @cocktail = Cocktail.find(params[:id])
  end
  def new
    @cocktail = Cocktail.new
  end
  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render "new"
    end
  end

  private

  def pixabay_random_pic(q = 'alcohol')
    response = HTTParty.get("https://pixabay.com/api/?key=8552570-540dab6f18162a9471dc11307&q=#{q}&image_type=photo&pretty=true")
    response["hits"].map do |photo|
      photo["largeImageURL"]
    end
  end

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end

