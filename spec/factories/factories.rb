FactoryGirl.define do
  factory :book do
    asin { Faker::Code.isbn }
    title { Faker::Commerce.product_name }
    photo "http://ecx.images-amazon.com/images/I/61FR%2BICtfkL._SL160_.jpg"
    published_on { rand(10.years).ago }
  end
end
