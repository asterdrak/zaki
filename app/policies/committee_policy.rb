# frozen_string_literal: true
class CommitteePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    true
  end

  def create?
    user&.admin?
  end

  def destroy?
    create?
  end

  def update?
    user&.admin? || permitted_committee_ids.include?(committee.id)
  end

  def use?
    if committee.is_a? Committee
      user&.admin? || permitted_committee_ids.include?(committee.id)
    else
      user.present?
    end
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.where(id: permitted_committee_ids)
      end
    end
  end
end
