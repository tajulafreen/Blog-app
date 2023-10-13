# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user ||= User.new # Guest user (not logged in)

    # Define abilities for different roles
    if user.admin?
      can :manage, :all # Admins can manage all resources
    else
      can :read, :all
      can :create, Post
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id

    end
  end
end
