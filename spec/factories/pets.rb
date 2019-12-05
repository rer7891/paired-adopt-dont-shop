FactoryBot.define do
  factory :random_pet, class: Pet do
    name              {Faker::App.name}
    description       {Faker::Lorem.sentence}
    sex               {Faker::Lorem.sentence}
    image_url         {Faker::LoremPixel.image}
    approximate_age   {Faker::Number.number(digits: 3)}
    association :shelter, factory: :random_shelter
  end
end
