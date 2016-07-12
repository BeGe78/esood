class Indicator < ActiveRecord::Base
    validates_presence_of :id1
    validates :name, uniqueness: true
    validates_presence_of :language
    validates_presence_of :topic
    validates :visible, :inclusion => { :in => ['Y'] }, :allow_nil => true
end
