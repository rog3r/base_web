class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.except_admin
      end
    end
  end

  def index?
    user.admin? or can? 'index'
  end

  def show? #TODO - validar sem or (user == @record)
    user.admin? or can? 'show' or (user == @record)
  end

  def create?
    user.admin? or can? 'create'
  end

  def update?
    user.admin? or can? 'update' or (user == @record)
  end

  def destroy?
    (user.admin? or can? 'destroy') and (user != @record)
  end

  alias_method :new?, :create? # delegate new to create method
  alias_method :edit?, :update?
end
