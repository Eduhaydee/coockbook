class HomeController < RecipesController
  def index
    @recipes = Recipe.all
    @recipe_featured = Recipe.where(featured: true)
    @recipe_unfeatured = Recipe.where(featured: false)
    @last_recipes = Recipe.where.not(id: @recipe_featured.map(&:id).concat(@recipe_unfeatured.map(&:id))).order(created_at: :desc).limit(10)
    #@recipe_types = RecipeType.all
  end

end