require 'test_helper'

describe Recipe do
  describe 'validity' do

    # let defines a method inside this test called recipe
    # it calls the block one time, but any subsequent times then
    # just returns the value that was returned from the original call
    let(:recipe) { Recipe.new }

    before do
      recipe.valid?
    end

    it 'requires a user' do
      # Gives an array, we want it say, it can't be blank
      recipe.errors[:user].must_include("can't be blank")
    end

    it 'requires a description' do
      recipe.errors[:description].must_include("can't be blank")
    end

    it 'requires a name' do
      recipe.errors[:name].must_include("can't be blank")
    end

    it 'requires the name to be unique for the same user' do
      existing_recipe = create(:recipe)
      recipe.name = existing_recipe.name
      recipe.user = existing_recipe.user
      recipe.valid?

      recipe.errors[:name].must_include('has already been taken')
    end

    # Does not have user
    it 'does not require the name to be unique for different users' do
      existing_recipe = create(:recipe)
      recipe.name = existing_recipe.name
      recipe.valid?

      recipe.errors[:name].wont_include('has already been taken')
      end
  end
end