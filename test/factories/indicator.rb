# This will guess the User class
FactoryBot.define do
  factory :indic1, class: Indicator do
    id1 'NE.RSB.GNFS.ZS'
    name 'NE.RSB.GNFS.ZS fr'
    language 'fr'
    topic 'NE.RSB.GNFS.ZS'
    visible 'Y'
    note 'note'
    source 'source'
  end
  factory :indic2, class: Indicator do
    id1 'NY.GDP.PCAP.CD'
    name 'GDP CD fr'
    language 'fr'
    topic 'GDP CD'
    note 'note'
    source 'source'
  end
  factory :indic3, class: Indicator do
    id1 'NE.RSB.GNFS.ZS'
    name 'NE.RSB.GNFS.ZS en'
    language 'en'
    topic 'NE.RSB.GNFS.ZS'
    visible 'Y'
    note 'note'
    source 'source'
  end
  factory :indic4, class: Indicator do
    id1 'NY.GDP.PCAP.CD'
    name 'GDP CD en'
    language 'en'
    topic 'GDP CD'
    note 'note'
    source 'source'
  end
end
