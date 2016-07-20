class Plan < ActiveRecord::Base
    validates :stripe_id, :name, :amount, :interval, presence: true
    validates_uniqueness_of :stripe_id 
    validates :amount, numericality: { greater_than: 100 } 
  def redirect_path(subscription)
    # you can return any path here, possibly referencing the given subscription
    '/'
  end    
end
