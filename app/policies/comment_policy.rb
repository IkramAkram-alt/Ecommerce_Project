class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.has_role? :buyer
  end

  def update?
    (user.has_role? :buyer) && (@user == @comment.user)
  end

  def destroy?
    (user.has_role? :buyer) && (@user == @comment.user)
  end

  def edit?
    (user.has_role? :buyer) && (@user == @comment.user)
  end

end
