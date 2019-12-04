FactoryBot.define do
 factory :shelter_1, class: Shelter do
   name    {"Best Golden Shelter"}
   address {"1313 Washington Ave"}
   city    {"Golden"}
   state   {"CO"}
   zip_code{"80401"}
 end

 factory :shelter_2, class: Shelter do
   name    {"Denver Adoptable Pets"}
   address {"2401 15th St #100"}
   city    {"Denver"}
   state   {"CO"}
   zip_code{"80202"}
 end

 factory :shelter_3, class: Shelter do
   name    {"Boulder Animal Shelter"}
   address {"633 S Broadway"}
   city    {"Boulder"}
   state   {"CO"}
   zip_code{"80305"}
 end

 factory :random_shelter, class: Shelter do
   name    {Faker::Company.name}
   address {Faker::Address.street_address}
   city    {Faker::Address.city}
   state   {Faker::Address.state}
   zip_code{Faker::Address.zip}
 end
end
