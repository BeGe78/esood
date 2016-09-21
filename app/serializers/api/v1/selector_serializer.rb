# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Serializer for the create selectors API
class Api::V1::SelectorSerializer < Api::V1::BaseSerializer
  attributes :data, :title, :same_scale, :nbticks,
             :legend1, :legend2,
             :highvalue, :lowvalue,
             :highvalue2, :lowvalue2,
             :unit, :unit2,
             :label_format,
             :label_format2,
             :mean1, :mean2,
             :coeflm1, :coeflm2,
             :coeflm3_1, :coeflm3_2,
             :meanrate1, :meanrate1,
             :cor
end

