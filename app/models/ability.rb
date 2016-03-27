class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

      # if user.has_role? :super_admin
      #   can :manage, :all
      # end

      # if user.has_role? :admin
      #   can :manage, Project
      # end

      #
      can :manage, Project do |project|
        project.creator == user || user.is_manager?(project)
      end

      can :read, Project do |project|
        user.projects.include? project
      end

      # can :manage, Sprint do |sprint|
      #   sprint.project.creator == user || user.is_manager?(sprint.project)
      # end
      #
      # can :read, Sprint do |sprint|
      #   user.projects.include? sprint.project
      # end



      # can :manage, Answer do |answer|
      #   answer.user == user || answer.question.user == user
      # end

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
