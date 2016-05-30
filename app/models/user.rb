class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :name  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  belongs_to :role
  before_save :assign_role

def assign_role
  self.role = Role.find_by name: "customer" if self.role.nil?
end
def admin?
  self.role.name == "Admin"
end
def customer?
  self.role.name == "Customer"
end
end
