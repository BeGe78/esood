class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :name  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  belongs_to :role
  has_many :invoicing_ledger_item, dependent: :destroy
  before_save :assign_role

def assign_role
  self.role = Role.find_by name: "Customer" if self.role.nil?
end
def admin?
  self.role.name == "Admin"
end
def customer?
  self.role.name == "Customer"
end
end
