# This will guess the User class
FactoryGirl.define do
 factory :france, class: Country do
  id1 "FRA"
  iso2code "FR"
  code "FRA"
  name "France"
  type "Country"
  language "fr"
  visible "Y"
 end
 factory :allemagne, class: Country do
  id1 "DEU"
  iso2code "DE"
  code "DEU"
  name "Allemagne"
  type "Pays"
  language "fr"
  visible "Y"
 end
 factory :germany, class: Country do
  id1 "DEU"
  iso2code "DE"
  code "DEU"
  name "Germany"
  type "Country"
  language "en"   
 end
end  
