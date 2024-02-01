# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role_id == 1
      can :manage, :all
    elsif user.role_id == 2
      can :manage, :all
      can :create, User, role_id: [1, 2]
    elsif user.role_id == 3
      can :manage, :all
      cannot :create, User, role_id: [1, 2,3]
    elsif user.role_id.in?([4, 5, 6])
      cannot :manage, User
  end
end
end
