# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# **Role model** used by devise and cancancan gems.  
# Role name shoud be unique and many users may have the same role  
# {RoleTest Corresponding tests:} 
class Role < ActiveRecord::Base
    validates :name, :description, presence: true
    validates_uniqueness_of :name
    has_many :users
end
