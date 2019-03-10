class HomeController < RecipesController
  def index
    @recipes = Recipe.all
    @recipe_featured = Recipe.where(featured: true)
    @recipe_unfeatured = Recipe.where(featured: false)
    #@recipe_types = RecipeType.all
  end

end