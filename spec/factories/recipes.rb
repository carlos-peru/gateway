FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    href { Faker::Internet.url }
    ingredients { Faker::Food.ingredient }
    thumbnail { Faker::LoremFlickr.image }

    skip_create
    initialize_with { new(attributes) }
  end
end