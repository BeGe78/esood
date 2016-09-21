# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# base Serializer for the others API serializers
class Api::V1::BaseSerializer < ActiveModel::Serializer
    
  # handles the create date 
  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end
  # handles the update date
  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end
