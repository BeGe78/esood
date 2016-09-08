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
  before_save :ensure_authentication_token
  # Role assignment: force *Customer* if nil
  # @return [role] 
  def assign_role
    self.role = Role.find_by name: 'Customer' if self.role.nil?
  end
  
  # check if role is admin
  def admin?
    self.role.name == 'Admin'
  end
  
  # check if role is customer
  def customer?
    self.role.name == 'Customer'
  end
  
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
