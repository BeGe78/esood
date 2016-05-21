class Country < ActiveRecord::Base
    #type is a reserved word so need to be renamed
    self.inheritance_column = 'zoink'
end
