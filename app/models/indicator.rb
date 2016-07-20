class Indicator < ActiveRecord::Base
    validates :id1, :language, :topic, :name , presence: true
    validates :id1, uniqueness: {scope: :language}
    validates :visible, inclusion: {in: ['Y']}, allow_nil: true     #visible is empty or Y  
    validates :language, inclusion: {in: ['en','fr']}               #language is en or fr
end
