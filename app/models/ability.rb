class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
       guest = User.new
       guest.role = Role.new
       guest.role.name = "Regular"
       user ||= guest # Guest user
       if user.admin?
        can :manage, :all
       elsif user.customer?
         can :read, Country
         can :read, Indicator
       else
         can :read, Country, :visible => "Y"
         can :read, Indicator, :visible => "Y"  
       end
       can :print_chart, Selector if (user.admin? or user.customer?)
       can :full_list  , Selector if (user.admin? or user.customer?)
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
