# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# **User model** used by devise gem.  
# Include default devise modules + :confirmable, :lockable  
# User must have a role. They may have invoicing_ledger_item.  
class User < ActiveRecord::Base
  
  validates_presence_of :name  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  belongs_to :role
  has_many :invoicing_ledger_item
  before_save :assign_role
# Role assignment: force *Customer* if nil
# @return [role] 
def assign_role
  self.role = Role.find_by name: "Customer" if self.role.nil?
end
# check if role is admin
def admin?
  self.role.name == "Admin"
end
# check if role is customer
def customer?
  self.role.name == "Customer"
end
end
