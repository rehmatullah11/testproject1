class Ability
  include CanCan::Ability
 
  def initialize(current_user)
      # can :manage, :all 
      # can :create, Project 
      # can :create, Project , current_user
      current_user||=User.new
      if current_user.usertype=='manager'
        can :create, Project 
        can :read, Project, creator_id: current_user.id
        can :edit, Project, creator_id: current_user.id
        can :destroy, Project, creator_id: current_user.id
        can :read, Bug, creator_id: current_user.id
        can :read, User, id: current_user.id
      elsif current_user.usertype == 'developer'
        can :read,Project do |project|
          project.users.include? (current_user)
        end
        can :read, Bug, solver_id: current_user.id
        can :update, Bug, solver_id: current_user.id
        can :read, User, id: current_user.id
      elsif current_user.usertype=='qa'
        can :read, Project do |project|
          project.users.include? (current_user)
        end
        can :create, Bug
        can :read, Bug, creator_id: current_user.id
        can :update, Bug, creator_id: current_user.id
        can :destroy, Bug, creator_id: current_user.id
        can :read, User, id: current_user.id
    end
   

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
