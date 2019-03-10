class HomeController < RecipesController
  def index
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
  end

end