require 'rails_helper'

feature 'User view your recipes' do
  scenario 'successfully' do    
    visit root_path
    expect(page).to_not have_link('Minhas receitas')
  end

  scenario 'User view recipes registers' do
    #cria os dados necessários
    user1 = User.create!(email: 'user1@email.com', password: 'user123')
    user2 = User.create!(email: 'user2@email.com', password: 'user234')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           featured: false, user: user1)

    another_recipe = Recipe.create(title: 'Feijoada',
                                   recipe_type: another_recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes',
                                   featured: false, user: user2)

    login_as user1, scope: :user
    visit root_path
    click_on 'Minhas Receitas'

    expect(page).to have_css('h2', text: 'Bolo de cenoura')
    expect(page).to_not have_css('h2', text: 'Feijoada')
    expect(current_path).to eq(my_recipes_recipes_path)

  end
end