# This will guess the User class
FactoryGirl.define do
  factory :indic1, class: Indicator do
    id1 "NY.GDP.PCAP.CN"
    name "GDP CN fr"
    language "fr"
    topic "GDP CN"
    visible "Y"
    note "note"
    source "source"
  end
  factory :indic2, class: Indicator do
    id1 "NY.GDP.PCAP.CD"
    name "GDP CD fr"    
    language "fr"
    topic "GDP CD"
    note "note"
    source "source"
  end
    factory :indic3, class: Indicator do
    id1 "NY.GDP.PCAP.CN"
    name "GDP CN en"
    language "en"
    topic "GDP CN"
    visible "Y"
    note "note"
    source "source"
  end
  factory :indic4, class: Indicator do
    id1 "NY.GDP.PCAP.CD"
    name "GDP CD en"    
    language "en"
    topic "GDP CD"
    note "note"
    source "source"
  end
end  
