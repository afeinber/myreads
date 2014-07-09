# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "alex"
    email "alex@example.com"
    password "password"
  end
end
