class SpreeMultiBlogsAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Spree::BlogEntry
    can :index, Spree::BlogEntry
  end
end
