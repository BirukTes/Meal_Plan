class User < ApplicationRecord
  include Clearance::User

  # User has many recipes, finds all the recipes that belong
  # (are associated with) to the user id
  has_many :recipes
end
