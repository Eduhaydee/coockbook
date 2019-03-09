class HomeController < RecipesController
  def index
    @recipes = Recipe.all
  end

end