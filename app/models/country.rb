# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# **Country model** used with WorldBank database.  
# Country name shoud be unique by language    
# Language is in en, fr  
# Visible is empty or Y
class Country < ActiveRecord::Base
    self.inheritance_column = 'zoink'                               #type is a reserved word so need to be renamed
    validates :id1, :iso2code, :code, :name, :language, :type , presence: true
    validates :name, uniqueness: {scope: :language}
    validates :visible, inclusion: {in: ['Y']}, allow_nil: true
    validates :language, inclusion: {in: ['en','fr']}
end
