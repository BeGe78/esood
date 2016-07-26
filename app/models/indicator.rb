# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# **Indicator model** used with WorldBank database.  
# Indicator 1 shoud be unique by language    
# Language is in en, fr  
# Visible is empty or Y  
# {IndicatorTest Corresponding tests:} 
class Indicator < ActiveRecord::Base
    validates :id1, :language, :topic, :name , presence: true
    validates :id1, uniqueness: {scope: :language}
    validates :visible, inclusion: {in: ['Y']}, allow_nil: true
    validates :language, inclusion: {in: ['en','fr']}
end
