require 'concerns/user_permission_concern'

class ApplicationPolicy
  include UserPermissionConcern

  attr_reader :user, :committee

  def initialize(user, committee)
    @user = user
    @committee = committee
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    include UserPermissionConcern

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end
end
