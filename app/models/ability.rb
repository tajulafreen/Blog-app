class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user ||= User.new # Guest user (not logged in)

    # Define abilities for different roles
    if user.admin?
      can :manage, :all # Admins can manage all resources
    else
      can :manage, Post, author: user
      can :manage, Comment, author: user
      can :read, :all

    end
  end
end
