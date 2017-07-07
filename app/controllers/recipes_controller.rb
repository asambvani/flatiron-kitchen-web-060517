class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all

  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.find_or_create_by(recipe_params)
    ingredients = params[:ingredients]
    if ingredients
      ingredients.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        recipe.ingredients << ingredient
      end
    end
    redirect_to recipe_path(recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.all
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    new_ingredients = params[:ingredients]
    if new_ingredients
      new_ingredients.map! do |ingredient_name|
        Ingredient.find_or_create_by(name: ingredient_name)
      end
      recipe.ingredients = new_ingredients
    else
      recipe.ingredients = []
    end
    redirect_to recipe_path(recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name)
  end
end
