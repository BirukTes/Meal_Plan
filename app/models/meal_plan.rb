class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meals

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user, presence: true

  def build_meals
    # Get all the ids the user recipe is associated with
    user_recipe_ids = user.recipes.pluck(:id)

    (start_date..end_date).each do |date|
      # The map method takes an enumerable object and a block,
      # and runs the block for each element, outputting each returned
      # value from the block (the original object is unchanged unless you use map!):

      # [1, 2, 3].map { |n| n * n } #=> [1, 4, 9]
      # Array and Range are enumerable types. map with a block returns an Array.
      # map! mutates the original array.
      #
      # Looks for every meal already built and finds unused ids,  short-hand style(map method)
      unused_recipe_ids = user_recipe_ids - meals.map(&:recipe_id)

      # Get the ids
      available_recipe_ids = if unused_recipe_ids.empty?
                               # All used up, start again
                               user_recipe_ids
                             else
                               # Still unused ids, continue
                               unused_recipe_ids
                             end

      # Build the meal plan, with date and randomised recipe_ids
      meals.build(date: date, recipe_id: available_recipe_ids.sample)
    end
  end
end