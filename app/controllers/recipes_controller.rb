class RecipesController < ApplicationController
  
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisine = Cuisine.all
  end
  
  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisine = Cuisine.all
      flash[:errors] = "Não foi possível salvar a receita"
      render :edit
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisine = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisine = Cuisine.all
      flash[:errors] = "Não foi possível salvar a receita"
      render :edit
    end
  end
  
  
  private
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method)
  end

end