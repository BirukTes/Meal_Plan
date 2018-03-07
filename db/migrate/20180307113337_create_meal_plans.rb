class CreateMealPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_plans do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
