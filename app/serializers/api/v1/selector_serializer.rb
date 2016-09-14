class Api::V1::SelectorSerializer < Api::V1::BaseSerializer
  attributes :data, :title, :same_scale, :nbticks,
             :legend1, :legend2,
             :highvalue, :lowvalue,
             :highvalue2, :lowvalue2,
             :unit, :unit2,
             :label_format, :label_format2
end

