FactoryGirl.define do
  factory :user do
    # Will ensure every single time create user is called,
    # unique email address is created, using ticking number
    sequence(:email) do |n|
      "example_user_#{n}@example.com"
    end
    password 'password'
  end
end
