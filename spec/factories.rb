FactoryGirl.define do
  factory :user do
    username     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end