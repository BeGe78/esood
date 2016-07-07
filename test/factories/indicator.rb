# This will guess the User class
FactoryGirl.define do
  factory :indic1, class: Indicator do
    id1 "NY.GDP.PCAP.CN"
    name "GDP CN"
    language "fr"
    visible "Y"
  end
  factory :indic2, class: Indicator do
    id1 "NY.GDP.PCAP.CD"
    name "GDP CD"
    language "fr"
    visible "Y"
  end
end  
