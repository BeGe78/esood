class Plan < ActiveRecord::Base
#    include Payola::Plan
    validates_presence_of :stripe_id
    validates_presence_of :name
    validates :amount, numericality: { greater_than: 100 } 
  def redirect_path(subscription)
    # you can return any path here, possibly referencing the given subscription
    '/'
  end    
end
