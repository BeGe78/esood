class Api::V1::SelectorSerializer < Api::V1::BaseSerializer
  attributes :data, :title, :legend1, :legend2, :highvalue, :lowvalue, :same_scale, :unit, :unit2
end
