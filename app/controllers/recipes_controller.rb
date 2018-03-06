class RecipesController < ApplicationController
  # Calls Clearance for login
  before_action :require_login

  # Shows the list of resources,
  # but likely only an abbreviated portion of those resources.
  def index
    # @recipes = Recipe.all
    # Ordered list
    @recipes = current_user.recipes.order(:id)
  end

  # Shows the full details of a single resource.
  # potentially with more information from other resources.
  def show
    # @recipe = Recipe.find(params[:id])
    @recipe = current_user.recipes.find(params[:id])
  end

  # Shows a new record form
  def new
    @recipe = current_user.recipes.build
  end

  # Creates a new record
  def create
    @recipe = current_user.recipes.build(recipe_params)

    # Make sure record has been saved
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe Created'
    else
      @errors = @recipe.errors.full_messages
      render :new
    end
  end

  # Shows edit record form
  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  # Updates the specified record
  def update
    # Find the recipe, because it needs to exist
    @recipe = current_user.recipes.find(params[:id])

    # Make sure record has been saved
    if @recipe.update_attributes(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe updated'
    else
      @errors = @recipe.errors.full_messages
      render :new
    end
  end

  # Deletes a record with id parameter passed in
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    # This inspection warns if a controller action contains more than one
    # model method call, after the initial .find or .new. It’s recommended that
    # you implement all business logic inside the model class, and use a single method to access it.
    # Inspired by "Ruby on Rails Code Quality Checklist"
    redirect_to recipe_path, notice: "Deleted Recipe: #{recipe.name}"
  end


  private

  # Wraps and uses the rails strong parameters
  def recipe_params
    # Params is special of type object, but behaves like a Hash
    # Allows us to require recipe as part of the form, permit specific attributes,
    # other than that will be ignored
    params.require(:recipe).permit(:name, :description)
  end
end