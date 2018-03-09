class User < ApplicationRecord
  include Clearance::User

  # User has many recipes, finds all the recipes that belong
  # (are associated with) to the user id
  has_many :recipes

  # User has many meal plans, find all the meal plans associated
  has_many :meal_plans

  # Provides an array of options for the user recipes
  def recipe_options
    # The map function, enumerates over an array and then it
    # executes a block on each item inside the array, then takes the return
    # value of the block and uses that to build a new array that is returned
    #
    recipes.map do |recipe|
      # In case, return the recipe name and id in an array
      # (array of arrays as the form builder select box expects)
      [recipe.name, recipe.id]
    end
  end
end
