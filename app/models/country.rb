class Country < ActiveRecord::Base
    self.inheritance_column = 'zoink'                               #type is a reserved word so need to be renamed
    validates :id1, :iso2code, :code, :name, :language, :type , presence: true
    validates :name, uniqueness: {scope: :language}
    validates :visible, inclusion: {in: ['Y']}, allow_nil: true     #visible is empty or Y    
    validates :language, inclusion: {in: ['en','fr']}               #language is en or fr
end
