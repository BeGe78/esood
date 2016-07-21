# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# **Plan model** used for stripe subscription.  
# Plan stripe_id shoud be unique as it is a key to link to stripe  
# Plan amount should be higher than 100 corresponding to 1.00€
class Plan < ActiveRecord::Base
    validates :stripe_id, :name, :amount, :interval, presence: true
    validates_uniqueness_of :stripe_id 
    validates :amount, numericality: { greater_than: 100 } 
  # define the redirection path after subscription is OK
  # @param subscription [String]  
  # @return [path] 
  def redirect_path(subscription)
    # you can return any path here, possibly referencing the given subscription
    '/'
  end    
end
