class MealPlan < ApplicationRecord
  belongs_to :user
  # Meal plan has meany meals.
  #
  # Inverse of: if meals are created on
  # a meal plan, then when a meal created in a has to many calls the
  # meal plan method on itself, it will hook back up to the parent
  #
  # Inverse of saves memory, allows creation of many children,
  # allows has many through by auto creating the necessary junction record
  #
  # Destroys the dependent (children), meals record will also be deleted
  #
  # First thing to put after the association, anonymous function (lambda), can
  # be used to set the order of things, or change the query
  has_many :meals, -> { order(:date) }, inverse_of: :meal_plan, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user, presence: true

  # Defines an attributes writer for the specified association(s).
  # The form builder fields for function, requires meal plan to define
  # and accept nested attributes call on it. So, the meal plan object is
  # allowed to receive form attributes fora nested model
  accepts_nested_attributes_for :meals

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

  # Override the printing of the object
  def to_s
    "#{start_date} - #{end_date}"
  end
end