# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:uid)  {|n| n }
  sequence(:name) {|n| "user-#{n}" }

  factory :user do
    provider "github"
    uid { generate(:uid) }
    name { generate(:name) }
  end
end
