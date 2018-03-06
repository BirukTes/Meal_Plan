FactoryGirl.define do
  factory :recipe do
    # Lazy attribute, whatever is called in here,
    # it will call the block every single time
    name { Faker::Hipster.sentence }
    description { Faker::Hipster.paragraph }
    association(:user)
  end
end
