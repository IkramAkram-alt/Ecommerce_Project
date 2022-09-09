class CartItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  def initialize(user, cart_item)
    @user = user
    @cart_item = cart_item
  end

  def create?
    user.has_role? :buyer
  end
end
