class RecipesController < ApplicationController
  
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      redirect_to @recipe
    end
  end
  
  private
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end

end