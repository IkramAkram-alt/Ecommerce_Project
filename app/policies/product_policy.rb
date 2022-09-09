class ProductPolicy < ApplicationPolicy
  class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  attr_reader :user , :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def update?
    (user.has_role? :seller) && (@user == @product.user)
  end

  def create?
    user.has_role? :seller
  end


  def new?
    user.has_role? :seller
  end

  def destroy?
    (user.has_role? :seller) && (@user == @product.user)
  end

  def edit?
    (user.has_role? :seller) && (@user == @product.user)
  end
end
