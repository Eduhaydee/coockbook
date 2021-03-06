require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user)

    # simula a ação do usuário
    login_as user, scope: :user
    visit root_path

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user)

    # simula a ação do usuário
    login_as user, scope: :user
    visit root_path

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'user not edit recipe of the other user' do
    user1 = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    recipe1 = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user1)

    user2 = User.create!(email: 'user2@email.com', password: 'user123')
    recipe2 = Recipe.create(title: 'Bolodechocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Derreta o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user2)

    # simula a ação do usuário
    login_as user2, scope: :user
    visit root_path
    click_on 'Bolodecenoura'  
   
    expect(page).to_not have_link("Editar")
  end

  scenario 'user not access url edit recipe' do
    user1 = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    recipe1 = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user1)

    user2 = User.create!(email: 'user2@email.com', password: 'user123')
    recipe2 = Recipe.create(title: 'Bolodechocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Derreta o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  featured: false, user: user2)

    # simula a ação do usuário
    login_as user2, scope: :user
    visit edit_recipe_path(recipe1)
   
    expect(current_path).to eq (root_path)
    expect(page).to have_content('Acesso negado!')

  end
end
